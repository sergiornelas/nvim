-- Google calendar
vim.cmd([[
  source ~/.cache/calendar.vim/credentials.vim
  " autocmd VimEnter * :clearjumps
]])

-- <MATERIAL>
vim.g.material_style = "deep ocean"

-- <ILLUMINATE>
vim.g.Illuminate_ftblacklist = { "NvimTree" }

-- Symbols listchars
vim.opt.listchars = {
	tab = "│ ",
	extends = "→",
	precedes = "←",
	trail = "·",
	nbsp = "␣",
	-- eol = "¬",
}
vim.opt.list = true

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown", "norg" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
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
  " wrap break
  set showbreak=↪\ 

  " Avoids automatic comment when enter
  au BufEnter * set fo-=c fo-=r fo-=o

  " Eliminate unnamed buffers
  function! CleanNoNameEmptyBuffers()
    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""])')
    if !empty(buffers)
    exe 'bd '.join(buffers, ' ')
    else
    echo 'No buffer deleted'
    endif
  endfunction

  " Avoid crashing when starts neovim with sessions
  " autocmd VimEnter * call timer_start(500, {-> execute("let g:rooter_manual_only = 0")})
  autocmd VimLeave * NvimTreeClose
]])

-- INCREASE PYTHON PLUGINS LOADING
-- vim.g.loaded_python_provider = 1
-- vim.g.python_host_skip_check = 1
-- vim.g.python_host_prog = "/usr/local/bin/python"
-- vim.g.python3_host_skip_check = 1
-- vim.g.python3_host_prog = "/usr/local/bin/python3"
