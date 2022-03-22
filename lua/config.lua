-- Neovide
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_transparency = 0.8
vim.g.neovide_refresh_rate = 60
vim.g.neovide_transparency = 0.85

-- HARDTIME
vim.g.hardtime_default_on = 1
vim.g.hardtime_maxcount = 6
--vim.g.hardtime_timeout = 1000

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
vim.cmd("set nofoldenable") --helps with everything fold

-- Clean empty files
vim.cmd([[
  function! CleanNoNameEmptyBuffers()
  let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""])')
  if !empty(buffers)
  exe 'bd '.join(buffers, ' ')
  else
  echo 'No buffer deleted'
  endif
  endfunction

  nnoremap <silent> ,C :call CleanNoNameEmptyBuffers()<CR>
]])
