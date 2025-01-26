--- @param mode string|table
--- @param key string
--- @param command string
local function map(mode, key, command)
	vim.keymap.set(mode, key, command, { noremap = true, silent = true })
end

map("n", "<leader>y", "<cmd>tabclose<cr>") --                       tab close
map("n", "d<leader>", "cc<esc>") --          	                     clear line
map("n", "<leader><leader>", "i<space><esc>") --                 adds a space
map("n", "<leader>lo", "<cmd>lopen<cr>") --                      open loclist
map("n", "<leader>q", "<cmd>copen<cr>") --                      open quickfix
map("n", "<leader>x", "<cmd>lua toggle_boolean()<cr>") --      toggle boolean
map("i", "<c-z>", "<c-g>u<Esc>[s1z=`]a<c-g>u") --              fix last spell
map("n", "<leader>j", "i<c-g>u<Esc>]s1z=`]a<c-g>u<esc>") --    fix next spell
map("n", "<leader>k", "i<c-g>u<Esc>[s1z=`]a<c-g>u<esc>") --    fix prev spell
map("n", "gG", "<cmd>%y<cr>") --            	               yank full buffer
map("n", "<leader><c-q>", "<cmd>qa!<cr>") -- 	              force exit neovim
map("n", "y<leader>", "^f:llyE") --                      yank secret password
map({ "n", "x" }, "<c-w><c-e>", "<cmd>vnew<cr>") -- new buffer vertical split
map("t", "<esc>", "<c-\\><c-n>") --               escape insert mode terminal
map("c", "<c-o>", "<c-p>") --             command prev option (vim: not used)
map("n", "<leader>n", '<cmd>lua toggle_file_in_split("~/notes/scratch/main.md")<cr>') -- toggle scratch file
map("n", "<leader>R", "<cmd>lua toggle_window_resize()<cr>") -- toggle auto resize window mode
map("n", "<c-q>", "<cmd>qa<cr>") -- 	 exit vim safely (vim: not used, or used for terminal control flow, visual block)

-- TOGGLE OPTIONS =================================
map("i", "<c-g><c-p>", "<cmd>set spell!<cr>")
map("i", "<c-g><c-a>", "<cmd>set wrap!<cr>")
map("i", "<c-g><c-b>", "<cmd>set nu!<cr>")
map("x", "<leader>p", "<cmd>set spell!<cr>")
map("x", "<leader>a", "<cmd>set wrap!<cr>")
map("x", "<leader>b", "<cmd>set nu!<cr>")

-- RESIZE WINDOW ==================================
map({ "n", "x" }, "<c-p>", "<cmd>resize +6<cr>") --                    resize up (vim: same as "k")
map({ "n", "x" }, "<c-n>", "<cmd>resize -6<cr>") --                  resize down (vim: same as "j")
map({ "n", "x" }, "<c-h>", "<cmd>vertical resize +6<cr>") -- resize left (vim: same as "h", "<BS>")
map({ "n", "x" }, "<c-;>", "<cmd>vertical resize -6<cr>") --                           resize right

-- remember that Q visual mode execute last macro in selected portion

-- leader free: h, v, m, o
-- h chatgpt?
-- o obisidan

-- ctrl free:
-- c-c

-- [ maps available
-- y, o, u
-- h, j
-- m?
