-- TODO: If another claude code is running, it should be closed

-- TODO: If user is in a different tab than claude code running, focusing in the window
-- with neovim session should be ignored. Only triggers that if we are currently in the same tab
-- where the claude code is running
local kitty_pane_id = nil
local diff_tab = nil
local nvim_pane_id = tonumber(vim.fn.getenv("KITTY_WINDOW_ID"))

local function pane_exists(id)
	if not id then
		return false
	end
	vim.fn.system('kitty @ ls 2>/dev/null | grep -q \'"id": ' .. id .. "'")
	return vim.v.shell_error == 0
end

local function focus_pane()
	if kitty_pane_id then
		vim.fn.system("kitty @ focus-window --match id:" .. kitty_pane_id)
	end
end

local function close_pane()
	if kitty_pane_id then
		vim.fn.system("kitty @ close-window --match id:" .. kitty_pane_id)
		kitty_pane_id = nil
	end
end

local function launch_pane(cmd_string, env_table)
	local env_args = ""
	for k, v in pairs(env_table or {}) do
		env_args = env_args .. "--env " .. k .. "=" .. vim.fn.shellescape(v) .. " "
	end
	local cwd = vim.fn.getcwd()
	vim.fn.system("kitty @ goto-layout tall")
	local result = vim.fn.system(
		"kitty @ launch --type=window --location=vsplit --title=claude --copy-env --cwd="
			.. vim.fn.shellescape(cwd)
			.. " "
			.. env_args
			.. cmd_string
	)
	kitty_pane_id = tonumber(vim.trim(result))
end

local augroup = vim.api.nvim_create_augroup("ClaudeCodeKitty", { clear = true })

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = augroup,
	callback = function()
		local bufname = vim.api.nvim_buf_get_name(0)
		if bufname:match("%(proposed%)") or bufname:match("%(NEW FILE %- proposed%)") then
			diff_tab = vim.fn.tabpagenr()
			if nvim_pane_id then
				vim.fn.system("kitty @ focus-window --match id:" .. nvim_pane_id)
				-- git diff in full screen:
				-- vim.fn.system("kitty @ goto-layout stack")
			end
			local opts = { buffer = true }
			vim.keymap.set("n", "<c-j>", function()
				vim.cmd.normal({ "]c", bang = true })
			end, opts)
			vim.keymap.set("n", "<c-k>", function()
				vim.cmd.normal({ "[c", bang = true })
			end, opts)
		end
	end,
})

vim.api.nvim_create_autocmd("BufWinLeave", {
	group = augroup,
	callback = function()
		local bufname = vim.api.nvim_buf_get_name(0)
		if bufname:match("%(proposed%)") or bufname:match("%(NEW FILE %- proposed%)") then
			-- Cuando aceptas/declinas los cambios, el layout vuelve a tall
			-- vim.fn.system("kitty @ goto-layout tall")
			-- ======================
			-- El focus regresa al panel de claude code cuando aceptas/declinas los cambios
			focus_pane()
		end
	end,
})

-- Focus Claude Code back when accepting/declining changes
vim.api.nvim_create_autocmd("TabClosed", {
	group = augroup,
	callback = function(ev)
		if tonumber(ev.file) == diff_tab then
			diff_tab = nil
			focus_pane()
		end
	end,
})

return {
	"coder/claudecode.nvim",
	lazy = false,
	enabled = true,
	opts = {
		terminal = {
			provider = {
				is_available = function()
					return true
				end,

				setup = function() end,

				open = function(cmd_string, env_table)
					if pane_exists(kitty_pane_id) then
						vim.fn.system("kitty @ goto-layout tall")
						focus_pane()
					else
						launch_pane(cmd_string, env_table)
					end
				end,

				close = close_pane,

				simple_toggle = function(cmd_string, env_table)
					if pane_exists(kitty_pane_id) then
						close_pane()
					else
						launch_pane(cmd_string, env_table)
					end
				end,

				focus_toggle = function(cmd_string, env_table)
					if pane_exists(kitty_pane_id) then
						focus_pane()
					else
						launch_pane(cmd_string, env_table)
					end
				end,

				get_active_bufnr = function()
					return nil
				end,
			},
		},
		-- Diff Integration
		diff_opts = {
			layout = "vertical", -- "vertical" or "horizontal"
			open_in_new_tab = true,
			keep_terminal_focus = false, -- If true, moves focus back to terminal after diff opens. [Doesn't work with my current custom provider].
			hide_terminal_in_new_tab = false,
			-- on_new_file_reject = "keep_empty", -- "keep_empty" or "close_window"

			-- Legacy aliases (still supported):
			-- vertical_split = true,
			-- open_in_current_tab = true,
		},
	},
	keys = {
		{ "g]", "<cmd>ClaudeCode --resume<cr>" }, -- (vim: :tselect on the tag under the cursor)
		{ "g[", "<cmd>ClaudeCode --continue<cr>" },
		{ "go", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" }, -- (vim: cursor to byte N in the buffer)
		{ "gl", "<cmd>ClaudeCodeSend<cr>", mode = "v" },
		{
			"gll",
			function()
				local mode = vim.fn.mode()
				if mode == "v" or mode == "V" then
					vim.cmd("ClaudeCodeSend")
				else
					vim.cmd("normal! V")
					vim.cmd("ClaudeCodeSend")
				end
			end,
			desc = "Send selection or current line to Claude",
		},
		{
			"gll",
			"<cmd>ClaudeCodeTreeAdd<cr>",
			desc = "Add file",
			ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
		},
		{ "gq", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" }, -- (vim: format Nmove text)
		{
			"g.",
			function()
				local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
				if #diagnostics == 0 then
					vim.notify("No diagnostics on current line", vim.log.levels.INFO)
					return
				end
				local lines = {}
				for _, d in ipairs(diagnostics) do
					table.insert(lines, d.message)
				end
				local filename = vim.fn.expand("%")
				local lnum = vim.fn.line(".")
				local text = "@" .. filename .. "#L" .. lnum .. "\n" .. table.concat(lines, "\n")

				local function send_text()
					vim.fn.system("kitty @ send-text --match id:" .. kitty_pane_id .. " " .. vim.fn.shellescape(text))
					focus_pane()
				end

				if pane_exists(kitty_pane_id) then
					send_text()
				else
					kitty_pane_id = nil
					vim.cmd("ClaudeCode")
					vim.defer_fn(send_text, 1000)
				end
			end,
		},
	},
}
