local options = {
  tabstop = 2,                             -- Width of tab is set to 2. Still it is a \t.
  shiftwidth = 2,                          -- Size of an Indent (in spaces). Applies for <</>> as well.
  expandtab = true,                        -- Tab key (insert mode) insert spaces instead of tab.
  titlestring = '%t',                      -- Title of window is the name of the file.
  title = true,                            -- Activate titlestring behaviour.
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  mouse = "a",                             -- allow the mouse to be used in neovim
  pumheight = 9,                           -- cmp menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 1,                         -- always show tabs
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 1000,                       -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 300,                        -- faster completion (4000ms default) USEFUL FOR FAST HIGHLIGHT, performance get low bc cursorhold is called frequently
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  relativenumber = false,                  -- set relative numbered lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  wrap = false,                            -- display lines as one long line
  scrolloff = 3,                           -- is one of my fav
  sidescrolloff = 3,
  guifont = "monospace:h17",               -- the font used in graphical neovim applications
  cursorline = false,                      -- highlight the current line
  number = false,                          -- set numbered lines
  cmdheight = 1,                           -- more space in the neovim command line for displaying messages
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

vim.opt.shortmess:append "c"

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
vim.cmd('set nofoldenable') 	   --helps with everything fold

-- ===============================================================================
-- vim.g.did_load_filetypes = 1
-- vim.g.neovide_cursor_vfx_mode = "pixiedust" -- neovide trail
-- vim.opt.linebreak = true -- clean linebreaks
-- vim.opt.guifont = "Liga SFMono Nerd Font:h14" -- set guifont for neovide
-- vim.opt.shortmess:append "casI" -- disable intro
-- vim.opt.whichwrap:append "<>hl" -- clean aligned wraps
-- vim.opt.guicursor:append "i:blinkwait700-blinkon400-blinkoff250"

-- --Remap for dealing with word wrap (not jumps wrapped lines)
-- vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
-- vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- PLUGINS
-- vim.g.hardtime_default_on = 1             -- Hard mode on/off.
-- vim.g.hardtime_maxcount = 3               -- Hard mode limit (hjkl).

-- PERFORMANCE
-- vim.opt.shadafile = "NONE"
-- vim.opt.shadafile = ""
-- vim.opt.shell = "/bin/bash"               -- Use shell bash default instead fish for example.
-- vim.opt.lazyredraw = true                 -- Macros or regexes on a large file, not draw the screen.

