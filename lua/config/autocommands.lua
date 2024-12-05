--- @param mode string
--- @param key string
--- @param command string
local function map(mode, key, command)
	vim.api.nvim_buf_set_keymap(0, mode, key, command, { noremap = true, silent = true })
end
local autocmd = vim.api.nvim_create_autocmd

-- Set group colors
vim.api.nvim_create_augroup("MyColors", { clear = true })
autocmd("ColorScheme", {
	group = "MyColors",
	pattern = "*",
	callback = function()
		local highlights = {
			{ "LineNr", { fg = "#807B7B" } },
			{ "Visual", { bg = "#52524e" } },
			{ "MsgArea", { fg = "#DACBA5" } },
			{ "CursorLine", { bg = "#25424D" } },
			{ "IndentLine", { fg = "#525050" } },
			{ "TreesitterContext", { bg = "#34312F" } },
			{ "MiniIndentscopeSymbol", { fg = "#DACBA5" } },
			{ "ContextVt", { fg = "#807B7B", italic = true } },
			{ "CursorLineNr", { bg = "#0f0e0e", fg = "#f3971b" } },
			{ "TreesitterContextBottom", { underline = true, sp = "#887F68" } },
			{ "LspInlayHint", { fg = "#74716A", bg = "#161514", italic = true } },
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
		vim.opt_local.colorcolumn = "80"
		vim.opt_local.textwidth = 80
		vim.opt_local.wrap = true
		map("i", "<c-g><c-]>", "<esc>o- [ ] ")
		map("i", "<c-g><c-[>", "<Esc>O- [ ] ")
		map("n", "gf", "<cmd>normal! $<cr><cmd>normal! h<cr><cmd>normal! gf<cr>")
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

-- Set mark and close Copilot chat
autocmd("FileType", {
	pattern = { "copilot-chat" },
	callback = function()
		map("n", "q", "mz<cmd>CopilotChatClose<cr>")
	end,
})

-- Show yank line highlight
autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Show cursor line only in active window
autocmd({ "InsertLeave", "WinEnter" }, { pattern = "*", command = "set cursorline" })
autocmd({ "InsertEnter", "WinLeave" }, { pattern = "*", command = "set nocursorline" })

-- Stop automatic comment when break line in insert mode
autocmd("BufEnter", {
	pattern = "*",
	command = "set fo-=cro",
})

-- Jump to the last place you’ve visited in a file before exiting
autocmd(
	"BufReadPost",
	{ command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

-- Abbreviations
-- <c-v>+space skip the abbreviation"
vim.cmd("iabbrev snext sergio.ornelas@nextiva.com")
vim.cmd("cabbrev sss SessionSave<cr>")
vim.cmd("cabbrev ssd SessionDelete<cr>")

-- Macros
-- switch ^[ to \<esc>, switch ^M to \<cr>, switch ^R to \<c-r>
-- sum columns visual selection
vim.g.n = "mxyGo\\<esc>pVGJ0y$:execute('let @t=\\<c-r>0')\\<cr>dd`x"

-- Reference commands ========================
-- Symbols listchars
-- opt.listchars = {
-- 	tab = "│ ",
-- 	extends = "→",
-- 	precedes = "←",
-- 	trail = "·",
-- 	nbsp = "␣",
-- 	-- eol = "¬",
-- }
-- opt.list = true

-- Execute command when vim leave
-- autocmd VimLeave * NvimTreeClose

-- Execute command when VimEnter and after some miliseconds
-- autocmd VimEnter * call timer_start(10, {-> execute("unmap [%")})

-- Execute multiple commands after a call timer
-- function CodeRunner()
--   execute 'RunCode'
--   execute 'lua require("colorful-winsep").NvimSeparatorDel()'
-- endfunction
-- nnoremap <leader>sp :Codi <bar> call timer_start(200, CodeRunner())<cr>

-- Execute keyboard command
-- :exe "normal \<C-W>\<C-w>"

-- enters diff mode, you can find text differences between two buffers. You need the two buffers & windows opened
-- :wind diffthis
