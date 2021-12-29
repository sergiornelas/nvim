-- vim.g.gruvbox_contrast_dark = 'hard'
-- vim.g.colors_name = 'srcery'
-- vim.cmd('colorscheme nord')
-- vim.opt.background='dark'
-- vim.g.transparent_window = true

-- colorscheme darkplus
-- colorscheme gruvbox
vim.cmd [[
try
  colorscheme kanagawa
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]

