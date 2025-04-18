local o = vim.opt

o.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
o.conceallevel = 2 --          so that `` is visible in markdown files, useful for markdown files
o.cursorline = true --         highlight the current line
o.expandtab = true --          convert tabs to spaces (useful for markdown extraspaces)
o.ignorecase = true --         ignore case in search patterns
o.linebreak = true --          avoid wrapping a line in the middle of a word.
o.number = true --             show lines number
o.numberwidth = 1 --           minimal number of columns to use for the line number
o.pumheight = 10 --            pop up menu height
o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,globals,localoptions" -- session start options
o.shiftwidth = 2 --            the number of spaces inserted for each indentation
o.showbreak = "↪ " --          wrap break icon
o.showcmd = false --           hide (partial) command in the last line of the screen (for performance)
o.signcolumn = "number" --     merges the number column and sign column into one
o.smartcase = true --          Override the 'ignorecase' option if the search pattern contains upper case characters.
o.smartindent = true --        make indenting smarter again
o.spelllang = "es,en" --       spelling language, found in spell/es.utf-8.spl
o.splitbelow = true --         force all horizontal splits to go below current window
o.splitright = true --         force all vertical splits to go to the right of current window
o.swapfile = false --          creates a swapfile
o.tabstop = 2 --               insert 2 spaces for a tab
o.termguicolors = true --      set term gui colors (most terminals support this)
o.timeoutlen = 500 --          controls how long neovim waits for the next key in a mapping or key sequence
o.undofile = true --           enable persistent undo
o.wrap = false --              display lines as one long line

-- neovim 0.11
if not vim.g.vscode then
	o.winborder = "single" --    add borders to hover lsp
end
