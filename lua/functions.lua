local g = vim.g
-- local opt = vim.opt
local api = vim.api

-- Set wrap and spell in markdown, gitcommit and norg files
-- api.nvim_create_autocmd({ "FileType" }, {
-- 	pattern = { "gitcommit", "markdown", "norg" },
-- 	callback = function()
-- 		opt.wrap = true
-- 		opt.spell = true
-- 	end,
-- })

-- Show yank line highlight
local highlight_group = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Go to last location when opening a buffer
api.nvim_create_autocmd(
	"BufReadPost",
	{ command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

-- Show cursor line only in active window
local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true })
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, { pattern = "*", command = "set cursorline", group = cursorGrp })
api.nvim_create_autocmd(
	{ "InsertEnter", "WinLeave" },
	{ pattern = "*", command = "set nocursorline", group = cursorGrp }
)

vim.cmd([[
  " Default colorscheme
  colorscheme kimbox

  " Macros in visual mode
  xnoremap ! :<C-u>call ExecuteMacroOverVisualRange()<CR>
  function! ExecuteMacroOverVisualRange()
    echo "!".getcmdline()
    execute ":'<,'>normal !".nr2char(getchar())
  endfunction

  " Paste command mode
  cnoremap <c-v> <c-r>*

  " Calendar
  source ~/.cache/calendar.vim/credentials.vim

  " Stop folding
  autocmd BufWritePost,BufEnter * set nofoldenable foldmethod=manual foldlevelstart=99

  " Wrap break icon
  set showbreak=↪\

  " Stop automatic comment when enter in insert mode
  au BufEnter * set fo-=c fo-=r fo-=o

  " Close nvimtree and TSContext
  autocmd VimLeave * NvimTreeClose
  autocmd VimLeave * TSContextDisable

  " Exit terminal
  :tnoremap <Esc> <C-\><C-n>

  " Eliminate terminal buffers when enter neovim
  function! DeleteBufferByExtension(strExt)
     let s:bufNr = bufnr("$")
     while s:bufNr > 0
         if buflisted(s:bufNr)
             if (matchstr(bufname(s:bufNr), "/".a:strExt."$") == "/".a:strExt )
                if getbufvar(s:bufNr, '&modified') == 0
                   execute "bd ".s:bufNr
                endif
             endif
         endif
         let s:bufNr = s:bufNr-1
     endwhile
  endfunction
  autocmd VimEnter * call timer_start(7, {-> execute("call DeleteBufferByExtension('fish')")})

  " Unmap matchit conflicts
  autocmd VimEnter * call timer_start(10, {-> execute("unmap [%")})
  autocmd VimEnter * call timer_start(15, {-> execute("unmap ]%")})
]])

-- Python plugins load faster
g.loaded_python_provider = 1
g.python_host_skip_check = 1
g.python_host_prog = "/usr/local/bin/python"
g.python3_host_skip_check = 1
g.python3_host_prog = "/usr/local/bin/python3"

-- Buffer list specific on folder project
-- vim.cmd([[
--   let gitroot = system("git rev-parse --show-toplevel 2>/dev/null | xargs echo -n")
--   if gitroot != ""
--     let histfile=gitroot . "/.history.shada"
--     execute 'set shadafile=' . histfile
--   endif
-- ]])

-- execute <esc>O command (for reference)
-- vim.cmd([[
--   :normal O
-- ]])

-- Symbols listchars (for reference)
-- opt.listchars = {
-- 	tab = "│ ",
-- 	extends = "→",
-- 	precedes = "←",
-- 	trail = "·",
-- 	nbsp = "␣",
-- 	-- eol = "¬",
-- }
-- opt.list = true
