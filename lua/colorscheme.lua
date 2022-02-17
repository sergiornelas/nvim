vim.cmd([[
  try
    colorscheme gruvbox
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
    set background=dark
  endtry
]])

-- vim.cmd([[
--   try
--     colorscheme material
--   catch /^Vim\%((\a\+)\)\=:E185/
--     colorscheme default
--     set background=dark
--   endtry
-- ]])
-- vim.g.material_style = "deep ocean"
