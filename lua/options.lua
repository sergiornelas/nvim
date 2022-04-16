local options = {
	hidden = true,
	tabstop = 2, -- Width of tab is set to 2. Still it is a \t.
	shiftwidth = 2, -- Size of an Indent (in spaces). Applies for <</>> as well.
	expandtab = true, -- Tab key (insert mode) insert spaces instead of tab.
	backup = false, -- creates a backup file
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 0, -- so that `` is visible in markdown files
	fileencoding = "utf-8", -- the encoding written to a file
	hlsearch = true, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	mouse = "a", -- allow the mouse to be used in neovim
	pumheight = 9, -- cmp menu height
	showmode = false, -- we don't need to see things like -- INSERT -- anymore
	showtabline = 1, -- always show tabs
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	termguicolors = true, -- set term gui colors (most terminals support this)
	timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true, -- enable persistent undo
	updatetime = 300, -- faster completion (4000ms default) USEFUL FOR FAST HIGHLIGHT, performance get low bc cursorhold is called frequently
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	relativenumber = false, -- set relative numbered lines
	numberwidth = 4, -- set number column width to 2 {default 4}
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	wrap = false, -- display lines as one long line
	sidescrolloff = 3,
	cursorline = false, -- highlight the current line
	number = false, -- set numbered lines
	cmdheight = 1, -- more space in the neovim command line for displaying messages
	scrolloff = 2, -- is one of my fav
	-- laststatus = 3,  --status line
	-- guifont = "monospace:h17",            -- the font used in graphical neovim applications
	-- titlestring = '%t',                   -- Title of window is the name of the file.
	-- title = true,                         -- Activate titlestring behavi ur.
}

for k, v in pairs(options) do
	vim.opt[k] = v
end
