-- Provider de claudecode.nvim para Rex: Claude Code corre en un bloque real de Rex
-- (split a la derecha de este nvim), no en un terminal-buffer. La lógica de
-- paneles vive en acciones de Rex (rex/claude.lua); aquí solo se llaman con
-- `rex do -b $REX_BLOCK <acción>`, así que ctx.block_id es el bloque de este nvim.
--
-- Lo carga plugins/claudecode.lua cuando nvim corre dentro de Rex ($REX_BLOCK);
-- fuera de Rex sigue el provider de kitty.

local M = {}

-- El bloque de Claude que lanzó este nvim. Si nvim se reinicia, se pierde: el
-- Claude que quede en la pestaña es un huérfano (ver claude_launch).
local claude_block = nil
local launched_once = false

local function rex_argv(action, args)
	return {
		"rex",
		"do",
		"-b",
		vim.env.REX_BLOCK,
		action,
		"--args",
		vim.json.encode(args or vim.empty_dict()),
		"--json",
	}
end

-- Llama una acción y espera su resultado (tabla), o nil si falló.
local function rex_do(action, args)
	local res = vim.system(rex_argv(action, args), { text = true }):wait()
	if res.code ~= 0 then
		return nil
	end
	local ok, out = pcall(vim.json.decode, res.stdout)
	return ok and type(out) == "table" and out or nil
end

-- Sin esperar: para mover el foco, que no tiene resultado que leer.
local function rex_async(argv)
	vim.system(argv, { text = true })
end

-- Muestra y enfoca el Claude de este nvim. false si ya no existe.
local function show()
	if not claude_block then
		return false
	end
	local r = rex_do("claude_show", { block_id = claude_block })
	if r and r.ok then
		return true
	end
	claude_block = nil
	return false
end

-- Pega el borrador rescatado del huérfano en cuanto el Claude nuevo está listo.
local function paste_draft(block_id, text, attempts)
	attempts = attempts or 0
	vim.system(rex_argv("claude_paste", { block_id = block_id, text = text }), { text = true }, function(res)
		local ok, out = pcall(vim.json.decode, res.stdout or "")
		local r = ok and type(out) == "table" and out or {}
		if not r.pasted and not r.gone and attempts < 20 then
			vim.defer_fn(function()
				paste_draft(block_id, text, attempts + 1)
			end, 200)
		end
	end)
end

local function launch(cmd_string, env_table)
	local env = env_table and next(env_table) and env_table or vim.empty_dict()
	local r = rex_do("claude_launch", {
		cmd = cmd_string,
		env = env,
		cwd = vim.fn.getcwd(),
		-- Solo en el primer lanzamiento: después, cualquier Claude de la pestaña
		-- es el de este nvim.
		replace_orphan = not launched_once,
	})
	launched_once = true
	if not (r and r.block_id) then
		vim.notify(
			"claudecode (Rex): no se pudo abrir Claude" .. (r and r.error and ": " .. r.error or ""),
			vim.log.levels.ERROR
		)
		return
	end
	claude_block = r.block_id
	if r.draft then
		paste_draft(r.block_id, r.draft)
	end
end

local function close()
	if claude_block then
		rex_async(rex_argv("claude_close", { block_id = claude_block }))
		claude_block = nil
	end
end

M.provider = {
	is_available = function()
		return true
	end,

	setup = function() end,

	open = function(cmd_string, env_table)
		if not show() then
			launch(cmd_string, env_table)
		end
	end,

	close = close,

	simple_toggle = function(cmd_string, env_table)
		if show() then
			close()
		else
			launch(cmd_string, env_table)
		end
	end,

	focus_toggle = function(cmd_string, env_table)
		if not show() then
			launch(cmd_string, env_table)
		end
	end,

	get_active_bufnr = function()
		return nil
	end,
}

function M.setup_autocmds()
	local augroup = vim.api.nvim_create_augroup("ClaudeCodeRex", { clear = true })

	-- Al abrir un diff: foco a nvim y navegación de hunks en el buffer del diff.
	vim.api.nvim_create_autocmd("User", {
		group = augroup,
		pattern = "ClaudeCodeDiffOpened",
		callback = function(ev)
			rex_async({ "rex", "focus", vim.env.REX_BLOCK })
			local diff_window = ev.data and ev.data.diff_window
			if not (diff_window and vim.api.nvim_win_is_valid(diff_window)) then
				return
			end
			local opts = { buffer = vim.api.nvim_win_get_buf(diff_window) }
			vim.keymap.set("n", "<c-j>", function()
				vim.cmd.normal({ "]c", bang = true })
			end, opts)
			vim.keymap.set("n", "<c-k>", function()
				vim.cmd.normal({ "[c", bang = true })
			end, opts)
		end,
	})

	-- Al cerrar el diff y después de cada envío (go/gl/gll): foco de vuelta a
	-- Claude. Aceptar o rechazar no cierra el diff (ver hook_diff_resolution).
	vim.api.nvim_create_autocmd("User", {
		group = augroup,
		pattern = { "ClaudeCodeDiffClosed", "ClaudeCodeSendComplete" },
		callback = show,
	})
end

-- Foco de vuelta a Claude en cuanto se acepta (:w) o se rechaza (gq) un diff.
-- claudecode.nvim no cierra el diff en ese momento: responde a Claude y espera a
-- que Claude llame a close_tab, así que ClaudeCodeDiffClosed puede llegar mucho
-- después (o nunca). Se envuelven las funciones que responden al diff; el
-- plugin las llama siempre por el módulo (M._resolve_diff_as_*).
--
-- Se llama desde el config del spec, con el plugin ya cargado.
function M.hook_diff_resolution()
	local diff = require("claudecode.diff")
	for _, name in ipairs({ "_resolve_diff_as_saved", "_resolve_diff_as_rejected" }) do
		local original = diff[name]
		diff[name] = function(tab_name, ...)
			local entry = diff._get_active_diffs()[tab_name]
			local was_pending = entry and entry.status == "pending"
			local result = original(tab_name, ...)
			if was_pending then
				vim.schedule(function()
					-- Si queda otro diff pendiente (p. ej. uno nuevo reemplazó a este),
					-- el foco se queda en nvim para responderlo.
					for _, d in pairs(diff._get_active_diffs()) do
						if d.status == "pending" then
							return
						end
					end
					show()
				end)
			end
			return result
		end
	end
end

-- g.: escribe el texto en el input de Claude y lo enfoca. Si no hay Claude, lo
-- abre y espera a que arranque.
function M.send_text(text)
	local function send()
		if not claude_block then
			return
		end
		rex_async({ "rex", "send", "-b", claude_block, text })
		show()
	end
	if show() then
		send()
	else
		vim.cmd("ClaudeCode")
		vim.defer_fn(send, 1000)
	end
end

return M
