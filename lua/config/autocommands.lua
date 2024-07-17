local group = vim.api.nvim_create_augroup("group", { clear = true })
local autocmd = vim.api.nvim_create_autocmd
local cmd = vim.cmd
local keymap = vim.keymap.set

-- Set specific options/keymaps for markdown files
autocmd("FileType", {
	pattern = { "markdown" },
	callback = function()
		vim.opt_local.colorcolumn = "80"
		vim.opt_local.textwidth = 80
		vim.opt_local.wrap = true
		keymap("n", "]e", function()
			cmd("silent! /^##\\+\\s.*$")
			cmd("nohlsearch")
		end)
		keymap("n", "[e", function()
			cmd("silent! ?^##\\+\\s.*$")
			cmd("nohlsearch")
		end)
		keymap("n", "gf", function()
			cmd("normal! $")
			cmd("normal! h")
			cmd("normal! gf")
		end)
	end,
})

-- Show yank line highlight
autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Jump to the last place you’ve visited in a file before exiting
autocmd(
	"BufReadPost",
	{ command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

-- Show cursor line only in active window
autocmd({ "InsertLeave", "WinEnter" }, { pattern = "*", command = "set cursorline", group = group })
autocmd({ "InsertEnter", "WinLeave" }, { pattern = "*", command = "set nocursorline", group = group })

cmd([[
  " Escape insert mode terminal
  :tnoremap <esc> <c-\><c-n>

  " Wrap break icon
  set showbreak=↪\ 

  " Stop automatic comment when break line in insert mode
  au BufEnter * set fo-=cro

  " Command prev option
  cnoremap <c-o> <c-p>
  " (vim: not used)

  " close quickfix and loclist with escape and q
  nnoremap <silent> <expr> <esc> &buftype == 'quickfix' ? ":ccl<cr>:lcl<cr>" : '<esc>'
  nnoremap <silent> <expr> q &buftype == 'quickfix' ? ":ccl<cr>:lcl<cr>" : 'q'

  " macros
  " switch ^[ to \<esc>, switch ^M to \<cr>, switch ^R to \<c-r>
  " sum columns visual selection
  let @n="mxyGo\<esc>pVGJ0y$:execute('let @t=\<c-r>0')\<cr>dd`x"

  " abbreviations
  " <c-v>+space skip the abbreviation"
  iab snext sergio.ornelas@nextiva.com
  cab sss SessionSave<cr>
  cab ssd SessionDelete<cr>

  " Set group colors
  augroup MyColors
    autocmd!
    autocmd ColorScheme * hi CursorLine guibg=#25424D
    autocmd ColorScheme * hi LineNr guifg=#6C6767
    autocmd Colorscheme * hi MsgArea guifg=#DACBA5
    autocmd Colorscheme * hi LspInlayHint guifg=#74716A guibg=#161514 gui=italic
    autocmd Colorscheme * hi ContextVt guifg=#807B7B gui=italic
    autocmd ColorScheme * hi MarkdownHeader1 guifg=#ebdbb2 guibg=#4F4545
    autocmd ColorScheme * hi MarkdownHeader2 guifg=#ebdbb2 guibg=#34312F
    autocmd ColorScheme * hi TreesitterContext guibg=#34312F
    autocmd ColorScheme * hi TreesitterContextBottom gui=underline guisp=#887F68
  augroup END
]])

-- Reference commands: ========================
-- usefull commands:
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
