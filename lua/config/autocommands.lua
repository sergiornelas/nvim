local api = vim.api
local group = api.nvim_create_augroup("group", { clear = true })
local cmd = api.nvim_create_autocmd

-- Set wrap and spell on specific file types
cmd("FileType", {
	pattern = { "norg", "markdown", "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
	end,
})

-- Show yank line highlight
cmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Jump to the last place you’ve visited in a file before exiting
cmd("BufReadPost", { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] })

-- Show cursor line only in active window
cmd({ "InsertLeave", "WinEnter" }, { pattern = "*", command = "set cursorline", group = group })
cmd({ "InsertEnter", "WinLeave" }, { pattern = "*", command = "set nocursorline", group = group })

api.nvim_exec(
	[[
  " Paste command mode
  cnoremap <c-v> <c-r>*

  " Exit terminal
  :tnoremap <esc> <c-\><c-n>

  " Magic multicursor
  xnoremap gT :s/\(\w.*\)/

  " Wrap break icon
  set showbreak=↪\ 

  " Stop automatic comment when enter in insert mode
  au BufEnter * set fo-=c fo-=r fo-=o

  " All folds are open
  set nofoldenable
]],
	false
)

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
