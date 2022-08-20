local g = vim.g
local opt = vim.opt

-- Set wrap and spell in markdown, gitcommit and norg files
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown", "norg" },
	callback = function()
		opt.wrap = true
		opt.spell = true
	end,
})

local api = vim.api

-- Show yank line highlight
local yankGrp = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
	command = "silent! lua vim.highlight.on_yank()",
	group = yankGrp,
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
  colorscheme emerald
  " Calendar
  source ~/.cache/calendar.vim/credentials.vim
  " Stop folding
  autocmd BufWritePost,BufEnter * set nofoldenable foldmethod=manual foldlevelstart=99
  " Wrap break icon
  set showbreak=↪\ 
  " Stop automatic comment when enter in insert mode
  au BufEnter * set fo-=c fo-=r fo-=o
  " Close nvimtree
  autocmd VimLeave * NvimTreeClose
  " Unmap matchit conflicts
  autocmd VimEnter * call timer_start(500, {-> execute("unmap [%")})
  autocmd VimEnter * call timer_start(510, {-> execute("unmap ]%")})
]])

-- Python plugins load faster
g.loaded_python_provider = 1
g.python_host_skip_check = 1
g.python_host_prog = "/usr/local/bin/python"
g.python3_host_skip_check = 1
g.python3_host_prog = "/usr/local/bin/python3"

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
