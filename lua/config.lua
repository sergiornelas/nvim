-- VIM ROOTER
vim.g.rooter_silent_chdir = 1
vim.g.rooter_manual_only = 1

-- SESSIONS (curdir eliminated)
vim.o.sessionoptions = "blank,buffers,folds,help,tabpages,winsize,winpos,terminal"

-- HIGHLIGHT
vim.g.cursorhold_updatetime = 100

-- GRUVBOX BABY
vim.g.gruvbox_baby_function_style = "NONE"
vim.g.gruvbox_baby_keyword_style = "italic"
vim.g.gruvbox_baby_telescope_theme = 1
vim.g.gruvbox_baby_transparent_mode = 0

-- MATERIAL
vim.g.material_style = "deep ocean"

-- ILLUMINATE
vim.g.Illuminate_ftblacklist = {'NvimTree'}
-- vim.api.nvim_set_keymap('n', '<a-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', {noremap=true})
-- vim.api.nvim_set_keymap('n', '<a-p>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', {noremap=true})

-- CLOSE NVIMTREE ?
vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"

-- Symbols
vim.opt.listchars = {
	-- eol = "↵",
	tab = "│·",
	extends = "⟩",
	precedes = "⟨",
	trail = "·",
}
vim.opt.list = true

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

--- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.cmd([[
  " Highlight on yank
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end

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
