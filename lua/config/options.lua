local o = vim.opt

o.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
o.conceallevel = 2 --          so that `` is visible in markdown files, useful for neorg files
o.cursorline = true --         highlight the current line
o.ignorecase = true --         ignore case in search patterns
o.linebreak = true --          avoid wrapping a line in the middle of a word.
o.mouse = "" --                allow the mouse to be used in neovim
o.pumheight = 10 --            pop up menu height
o.shiftwidth = 2 --            the number of spaces inserted for each indentation
o.showcmd = false --           hide (partial) command in the last line of the screen (for performance)
o.signcolumn = "yes" --        always show the sign column, otherwise it would shift the text each time
o.smartcase = true --          Override the 'ignorecase' option if the search pattern contains upper case characters.
o.smartindent = true --        make indenting smarter again
o.spelllang = "es,en" --       spelling language, found in spell/es.utf-8.spl
o.splitbelow = true --         force all horizontal splits to go below current window
o.splitright = true --         force all vertical splits to go to the right of current window
o.swapfile = false --          creates a swapfile
o.tabstop = 2 --               insert 2 spaces for a tab
o.termguicolors = true --      set term gui colors (most terminals support this)
o.undofile = true --           enable persistent undo
o.wrap = false --              display lines as one long line

-- windows options:
-- winminwidth = 10
-- winwidth = 10
-- winminheight = 10
-- winheight = 10
