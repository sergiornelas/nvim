-- INCREASE PYTHON PLUGINS LOADING
vim.g.loaded_python_provider = 1
vim.g.python_host_skip_check = 1
vim.g.python_host_prog = "/usr/local/bin/python"
vim.g.python3_host_skip_check = 1
vim.g.python3_host_prog = "/usr/local/bin/python3"

-- VIM ROOTER SILENT WHEN SWITCHING TO DIFFERENT PROJECTS
vim.g.rooter_silent_chdir = 1

-- Highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])

vim.opt.shortmess:append("c")

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
-- vim.cmd("set nofoldenable") --helps with everything fold

vim.g.material_style = "deep ocean"

-- Eliminate unnamed buffers
vim.cmd([[
  function! CleanNoNameEmptyBuffers()
    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""])')
    if !empty(buffers)
    exe 'bd '.join(buffers, ' ')
    else
    echo 'No buffer deleted'
    endif
  endfunction
]])
