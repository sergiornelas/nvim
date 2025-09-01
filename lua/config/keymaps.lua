--- @param mode string|table
--- @param key string
--- @param command string|function
local function map(mode, key, command)
	vim.keymap.set(mode, key, command, { noremap = true, silent = true })
end

map("n", "<leader>T", "<cmd>tabclose<cr>") --                       tab close
map("n", "d<leader>", "cc<esc>") --          	                     clear line
map("n", "<leader><leader>", "i<leader><esc>") --                adds a space
map("n", "<leader>lo", "<cmd>lopen<cr>") --                      open loclist
map("n", "<leader>q", "<cmd>copen<cr>") --                      open quickfix
map("n", "<leader>x", "<cmd>lua toggle_boolean()<cr>") --      toggle boolean
map("n", "gG", "<cmd>%y<cr>") --            	               yank full buffer
map("n", "<leader><c-q>", "<cmd>qa!<cr>") -- 	              force exit neovim
map({ "n", "x" }, "<c-w><c-u>", "<cmd>vnew<cr>") -- new buffer vertical split
map("t", "<esc>", "<c-\\><c-n>") --               escape insert mode terminal
map("n", "<leader>n", '<cmd>lua toggle_file_in_split("~/notes/scratch/main.md")<cr>') -- toggle scratch file
map("n", "<leader>R", "<cmd>lua toggle_window_resize()<cr>") -- toggle auto resize window mode
map("n", "<c-q>", "<cmd>qa<cr>") -- 	 exit vim safely (vim: not used, or used for terminal control flow, visual block)
map("i", "<c-c>", "<esc>^y$:execute 'read !echo \"scale=2; ' . @0 . '\" | bc'<cr>kA =<esc>J") -- calculate current math expression

-- Toggle options =================================
map({ "n", "x" }, "<leader>p", "<cmd>set spell!<cr>")
map({ "n", "x" }, "<leader>a", "<cmd>set wrap!<cr>")
map({ "n", "x" }, "<leader>b", "<cmd>set nu!<cr>")
map("i", "<c-g><c-p>", "<cmd>set spell!<cr>")
map("i", "<c-g><c-a>", "<cmd>set wrap!<cr>")
map("i", "<c-g><c-b>", "<cmd>set nu!<cr>")
map({ "n", "x" }, "<leader>v", function()
	---@diagnostic disable-next-line: undefined-field
	vim.opt.virtualedit = vim.opt.virtualedit:get()[1] == "all" and "" or "all"
end)

-- Resize window ==================================
map({ "n", "x" }, "<c-w><c-y>", "<cmd>resize +6<cr>") --          resize up
map({ "n", "x" }, "<c-w><c-e>", "<cmd>resize -6<cr>") --          resize down
map({ "n", "x" }, "<c-w><c-m>", "<cmd>vertical resize +6<cr>") -- resize left
map({ "n", "x" }, "<c-w><c-;>", "<cmd>vertical resize -5<cr>") -- resize right

-- wincmd: a, spacebar

-- remember that Q visual mode execute last macro in selected portion

-- ctrl free:
-- c-h (vim: same as "h", "<BS>")

-- [ maps available
-- y, o, u
-- h
-- n, m?

vim.api.nvim_create_user_command("Google", function(o)
	-- local escaped = require('socket.url').escape(o.args)
	local escaped = vim.uri_encode(o.args)
	local url = ("https://www.google.com/search?q=%s"):format(escaped)
	vim.ui.open(url)
end, { nargs = 1, desc = "just google it" })
map("n", "<leader>gw", ":Google ")
