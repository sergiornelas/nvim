local g = vim.g
local api = vim.api
local group = api.nvim_create_augroup("group", { clear = true })

-- Set wrap and spell on specific file types
api.nvim_create_autocmd("FileType", {
	pattern = { "norg", "markdown", "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Show yank line highlight
api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Jump to the last place you’ve visited in a file before exiting
api.nvim_create_autocmd(
	"BufReadPost",
	{ command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

-- Show cursor line only in active window
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, { pattern = "*", command = "set cursorline", group = group })
api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, { pattern = "*", command = "set nocursorline", group = group })

api.nvim_exec(
	[[
  " Paste command mode
  cnoremap <c-v> <c-r>*

  " Exit terminal
  :tnoremap <Esc> <C-\><C-n>

  " Magic multicursor
  xnoremap gt :s/\(\w.*\)/

  " Stop folding
  autocmd BufWritePost,BufEnter * set nofoldenable foldmethod=manual foldlevelstart=99

  " Wrap break icon
  set showbreak=↪\ 

  " Stop automatic comment when enter in insert mode
  au BufEnter * set fo-=c fo-=r fo-=o
]],
	false
)

-- Python plugins load faster
g.loaded_python_provider = 1
g.python_host_skip_check = 1
g.python_host_prog = "/usr/local/bin/python"
g.python3_host_skip_check = 1
g.python3_host_prog = "/usr/local/bin/python3"

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

-- execute <esc>O command
-- vim.api.nvim_exec([[
--   :normal O
-- ]])

-- Execute command when vim leave
-- autocmd VimLeave * TSContextDisable

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