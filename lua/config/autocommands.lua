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
			{ "MsgArea", { fg = "#DACBA5" } },
			{ "CursorLine", { bg = "#25424D" } },
			{ "TreesitterContext", { bg = "#34312F" } },
			{ "ContextVt", { fg = "#807B7B", italic = true } },
			{ "CursorLineNr", { bg = "#0f0e0e", fg = "#f3971b" } },
			{ "MarkdownHeader1", { fg = "#ebdbb2", bg = "#4F4545" } },
			{ "MarkdownHeader2", { fg = "#ebdbb2", bg = "#34312F" } },
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
		map("i", "<c-g><c-[>", "<esc>o- [ ] ")
		map("i", "<c-g><c-]>", "<Esc>O- [ ] ")
		map("n", "]e", "<cmd>silent! /^##\\+\\s.*$<cr><cmd>nohlsearch<cr>")
		map("n", "[e", "<cmd>silent! ?^##\\+\\s.*$<cr> <cmd>nohlsearch<cr>")
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
-- usefull commands
-- :wind diffthis - enters diff mode, you can find text differences between two buffers. You need the two buffers & windows opened

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

-- Eliminate terminal buffers when enter neovim
-- function! DeleteBufferByExtension(strExt)
--    let s:bufNr = bufnr("$")
--    while s:bufNr > 0
--        if buflisted(s:bufNr)
--            if (matchstr(bufname(s:bufNr), "/".a:strExt."$") == "/".a:strExt )
--               if getbufvar(s:bufNr, '&modified') == 0
--                  execute "bd ".s:bufNr
--               endif
--            endif
--        endif
--        let s:bufNr = s:bufNr-1
--    endwhile
-- endfunction
-- autocmd VimEnter * call timer_start(7, {-> execute("call DeleteBufferByExtension('fish')")})

-- Execute multiple commands after a call timer
-- function CodeRunner()
--   execute 'RunCode'
--   execute 'lua require("colorful-winsep").NvimSeparatorDel()'
-- endfunction
-- nnoremap <leader>sp :Codi <bar> call timer_start(200, CodeRunner())<cr>

-- Auto window resize
-- vim.cmd([[
-- augroup ReduceNoise
--     autocmd!
--     autocmd WinEnter * :call ResizeSplits()
--     autocmd FileType NvimTree set winwidth&
-- augroup END
-- function! ResizeSplits()
--     set winwidth=110
--     wincmd =
-- endfunction
-- ]])

--Execute command for specific filetype
-- if &ft == "lua"
--   set winwidth=110
-- endif

-- Map command for multiple filetypes
-- au FileType javascript,javascriptreact nnoremap...

-- Execute keyboard command
-- :exe "normal \<C-W>\<C-w>"
