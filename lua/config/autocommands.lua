--- @param mode string
--- @param key string
--- @param command string
local function map(mode, key, command)
	vim.api.nvim_buf_set_keymap(0, mode, key, command, { noremap = true, silent = true })
end
local autocmd = vim.api.nvim_create_autocmd
local create_group = vim.api.nvim_create_augroup

-- Set group colors
create_group("MyColors", { clear = true })
autocmd("ColorScheme", {
	group = "MyColors",
	pattern = "*",
	callback = function()
		local highlights = {
			{ "BlinkCmpDoc", { bg = "#151413", fg = "#efe4ca" } },
			{ "BlinkCmpLabel", { fg = "#efe4ca" } },
			{ "BlinkCmpLabelMatch", { fg = "#70afb0" } },
			{ "BlinkCmpMenu", { bg = "#1f1e1c" } },
			{ "BlinkCmpMenuSelection", { bg = "#4b4a48" } },
			{ "Comment", { fg = "#928374", italic = true } },
			{ "ContextVt", { fg = "#716a56", italic = true } },
			{ "CursorLine", { bg = "#25424D" } },
			{ "CursorLineNr", { bg = "#0f0e0e", fg = "#afacac" } },
			{ "HlSearchLensNear", { fg = "#ebdbb2", bg = "#4f0000" } },
			{ "HlSearchNear", { link = "None" } },
			{ "LineNr", { fg = "#807B7B" } },
			{ "LspInlayHint", { fg = "#74716A", italic = true } },
			{ "LspReferenceRead", { fg = "#DACBA5", bg = "#403e3e" } },
			{ "LspReferenceText", { fg = "#DACBA5", bg = "#403e3e" } },
			{ "LspReferenceWrite", { fg = "#DACBA5", bg = "#403e3e" } },
			{ "MiniIndentscopeSymbol", { fg = "#DACBA5" } },
			{ "MsgArea", { fg = "#DACBA5" } },
			{ "SnacksIndent", { fg = "#525050" } },
			{ "TreesitterContext", { bg = "#34312F" } },
			{ "TreesitterContextBottom", { underline = true, sp = "#887F68" } },
			{ "Visual", { bg = "#52524e" } },
			{ "VisualNonText", { fg = "#9d9681", bg = "#52524e" } },
		}
		for _, highlight in ipairs(highlights) do
			vim.api.nvim_set_hl(0, highlight[1], highlight[2])
		end
	end,
})

-- Set specific options/keymaps for markdown files
autocmd("FileType", {
	pattern = { "markdown" },
	callback = function()
		-- manual setting: set cc=80
		vim.opt_local.colorcolumn = "80"
		vim.opt_local.textwidth = 80
		map("n", "y<leader>", "^f:llyE") -- yank secret password
		map("i", "<c-g><c-space>", "- [ ] ") -- create a checkbox current line
		map("i", "<c-g><c-g>", "<esc>o- [ ] ") -- create a checkbox below
		map("i", "<c-g><c-t>", "<esc>O- [ ] ") -- create a checkbox above
		map("n", "gf", "<cmd>normal! $hgf<cr>") -- go to file under cursor
		map("n", "<leader><esc>", "Gmxo<esc>`xgwj") -- break line down and format the lines below
		map("i", "<c-z>", "<c-g>u<Esc>[s1z=`]a<c-g>u") -- fix last spell
		map("n", "<leader>j", "i<c-g>u<Esc>]s1z=`]a<c-g>u<esc>") -- fix next spell
		map("n", "<leader>k", "i<c-g>u<Esc>[s1z=`]a<c-g>u<esc>") -- fix prev spell
	end,
})

-- Close quickfix and loclist with escape and q
autocmd("FileType", {
	pattern = { "qf" },
	callback = function()
		map("n", "<esc>", "<cmd>ccl<cr><cmd>lcl<cr>")
		map("n", "q", "<cmd>ccl<cr><cmd>lcl<cr>")
	end,
})

-- Show yank line highlight
if vim.g.vscode then
	autocmd("TextYankPost", {
		callback = function()
			vim.highlight.on_yank()
		end,
	})
end

-- Show cursor line only in active window
autocmd({ "InsertLeave", "WinEnter" }, { pattern = "*", command = "set cursorline" })
autocmd({ "InsertEnter", "WinLeave" }, { pattern = "*", command = "set nocursorline" })

-- Stop automatic comment when break line in insert mode
autocmd("BufEnter", {
	pattern = "*",
	command = "set fo-=cro",
})

-- Jump to the last place you've visited in a file before exiting
local function augroup(name)
	return create_group("lazyvim_" .. name, { clear = true })
end
autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
			return
		end
		vim.b[buf].lazyvim_last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Trigger equalize windows function
autocmd("VimResized", {
	group = create_group("resize_splits", { clear = true }),
	callback = function()
		auto_equalize_window_widths()
	end,
})

-- Show LSP progress
---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
autocmd("LspProgress", {
	---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
		if not client or type(value) ~= "table" then
			return
		end
		local p = progress[client.id]
		for i = 1, #p + 1 do
			if i == #p + 1 or p[i].token == ev.data.params.token then
				p[i] = {
					token = ev.data.params.token,
					msg = ("[%3d%%] %s%s"):format(
						value.kind == "end" and 100 or value.percentage or 100,
						value.title or "",
						value.message and (" **%s**"):format(value.message) or ""
					),
					done = value.kind == "end",
				}
				break
			end
		end
		local msg = {} ---@type string[]
		progress[client.id] = vim.tbl_filter(function(v)
			return table.insert(msg, v.msg) or not v.done
		end, p)
		local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
		---@diagnostic disable-next-line: param-type-mismatch
		vim.notify(table.concat(msg, "\n"), "info", {
			id = "lsp_progress",
			title = client.name,
			opts = function(notif)
				notif.icon = #progress[client.id] == 0 and " "
					---@diagnostic disable-next-line: undefined-field
					or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
			end,
		})
	end,
})

-- Abbreviations
-- <c-v>+space skip the abbreviation"
vim.cmd("cabbrev sss SessionSave<cr>")
vim.cmd("cabbrev ssd SessionDelete<cr>")

-- Macros
-- switch ^[ to \<esc>, switch ^M to \<cr>, switch ^R to \<c-r>
-- sum columns visual selection
vim.g.n = "mxyGo\\<esc>pVGJ0y$:execute('let @t=\\<c-r>0')\\<cr>dd`x"

-- Reference commands ========================
-- Execute command when VimEnter and after some miliseconds
-- autocmd VimEnter * call timer_start(10, {-> execute("unmap [%")})

-- Execute multiple commands after a call timer
-- function CodeRunner()
--   execute 'RunCode'
--   execute 'lua require("colorful-winsep").NvimSeparatorDel()'
-- endfunction
-- nnoremap <leader>sp :Codi <bar> call timer_start(200, CodeRunner())<cr>

-- enters diff mode, you can find text differences between two buffers. You need the two buffers & windows opened
-- :wind diffthis
