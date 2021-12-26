local options = {
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 2,                           -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  mouse = "a",                             -- allow the mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,                         -- always show tabs
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 1000,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 300,                        -- faster completion (4000ms default) USEFUL FOR FAST HIGHLIGHT, performance get low bc cursorhold is called frequently
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- insert 2 spaces for a tab
  -- cursorline = true,                       -- highlight the current line
  -- number = true,                           -- set numbered lines
  relativenumber = false,                  -- set relative numbered lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  wrap = false,                            -- display lines as one long line
  scrolloff = 8,                           -- is one of my fav
  sidescrolloff = 8,
  guifont = "monospace:h17",               -- the font used in graphical neovim applications
}
--
-- vim.opt.shortmess:append "c"
--
for k, v in pairs(options) do
  vim.opt[k] = v
end
--
-- vim.cmd "set whichwrap+=<,>,[,],h,l"
-- vim.cmd [[set iskeyword+=-]]
-- vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work

-- ===============================================================================
--- Do not source the default filetype.vim
-- vim.g.did_load_filetypes = 1
-- vim.g.shell = "/bin/bash" --fish has speed issues with nvim-tree
-- vim.g.neovide_cursor_vfx_mode = "pixiedust" -- neovide trail
-- vim.opt.undofile = true -- enable persistent undo
-- vim.opt.swapfile = false -- disable swap
-- -- vim.opt.cursorline = true -- enable cursorline
-- vim.opt.mouse = "a" -- enable mouse
-- vim.opt.signcolumn = "yes" -- enable signcolumn
-- vim.opt.updatetime = 250
-- vim.opt.clipboard = "unnamedplus" -- enable universal clipboard
-- vim.opt.scrolloff = 3 -- leave 3 lines up/down while scrolling
-- vim.opt.tabstop = 4 -- tabs should be 4 "space" wide
-- vim.opt.shiftwidth = 4 -- tabs should be 4 "space" wide
-- vim.opt.expandtab = true -- tabs should be 4 "space" wide
-- vim.opt.linebreak = true -- clean linebreaks
-- vim.opt.number = false -- disable numbers
-- vim.opt.numberwidth = 2 -- two wide number column
-- vim.opt.guifont = "Liga SFMono Nerd Font:h14" -- set guifont for neovide
-- vim.opt.shortmess:append "casI" -- disable intro
-- vim.opt.whichwrap:append "<>hl" -- clean aligned wraps
-- vim.opt.guicursor:append "i:blinkwait700-blinkon400-blinkoff250"
--
-- --Remap for dealing with word wrap
-- vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
-- vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })
--
-- -- Highlight on yank
-- vim.cmd [[
--   augroup YankHighlight
--     autocmd!
--     autocmd TextYankPost * silent! lua vim.highlight.on_yank()
--   augroup end
-- ]]

-- READ VALUES
-- vim.o => Sirve para leer o modificar opciones generales del editor:
--          vim.o.background = 'light'
-- vim.g => Lee o modifica valores globales. Aquí más que todo encontrarán valores usados por PLUGINS.
--          La única opción que conozco que no está necesariamente ligada a un plugin es la tecla líder.
--          vim.g.mapleader = ' '

-- TABS/INDENTATION
-- vim.opt.tabstop = 2                       -- Width of tab is set to 2. Still it is a \t.
                                          -- Tab space value when reading a file.
-- vim.opt.shiftwidth = 2                    -- Size of an Indent (in spaces). Applies for <</>> as well.
-- vim.opt.expandtab = true                  -- Tab key (insert mode) insert spaces instead of tab.
-- vim.opt.softtabstop = 2                   -- Tab key (insert mode) insert spaces instead of tab.
-- vim.opt.smarttab = true                   -- Tab key (insert mode) insert spaces instead of tab.

-- MAIN CONFIGURATIONS
-- vim.opt.number = true                     -- Show numbers column.
-- vim.opt.ignorecase = true                 -- Ignore case when filter.
-- vim.opt.clipboard = 'unnamedplus'         -- Copy & paste outside vim.
-- vim.opt.titlestring = '%t'                -- Title of window is the name of the file.
-- vim.opt.title = true                      -- Activate titlestring behaviour.
-- vim.wo.wrap = false                       -- Display long lines as just one line.
-- vim.opt.splitbelow = true                 -- Horizontal splits will be below.
-- vim.opt.splitright = true                 -- Vertical splits will be right.
-- vim.opt.pumheight = 9                     -- Autocompletion max number items (lsp, snippet, buffer).
-- vim.opt.scrolloff = 3                     -- Buffer margin (test with H,L).
-- vim.cmd('set nonumber')
-- vim.cmd('set nofoldenable')

-- AESTHETIC
-- vim.opt.termguicolors = true              -- Important for adding #BF616A, nvimtree and telescope colors.
-- vim.g.t_Co = 256                          -- Show all gamma colors.
-- vim.g.colors_name = 'srcery'
-- vim.cmd('colorscheme nord')
vim.g.gruvbox_contrast_dark = 'hard'
-- vim.o.background='dark'
vim.cmd([[colorscheme gruvbox]])
-- vim.opt.transparent_window = true

-- PLUGINS
-- vim.g.hardtime_default_on = 1             -- Hard mode on/off.
-- vim.g.hardtime_maxcount = 3               -- Hard mode limit (hjkl).
-- vim.g["sneak#label"] = true								-- Sneak.
-- vim.g["sneak#use_ic_scs"] = 1							-- Sneak insensitive case
-- vim.g["sneak#s_next"] = 1									-- Sneak immediatly moves to the next instance of search.
-- vim.g["sneak#prompt"] = '🔎'							-- Sneak cool prompt.
-- vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'} --Quickscope.
-- vim.g.qs_max_char = 150										-- Quickscope max characters.

-- PERFORMANCE
-- vim.opt.shadafile = "NONE"
-- vim.opt.shadafile = ""
-- vim.opt.shell = "/bin/bash"               -- Use shell bash default instead fish for example.
-- vim.opt.lazyredraw = true                 -- Macros or regexes on a large file, not draw the screen.

