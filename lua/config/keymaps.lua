local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "d<leader>", "cc<esc>", opts) --          	                    clear line
keymap("n", "<leader><leader>", "i<space><esc>", opts) --                 adds a space
keymap("n", "[<leader>", "mxO<esc>`x", opts) --       	                 break line up
keymap("i", "<c-z>", "<c-g>u<Esc>[s1z=`]a<c-g>u", opts) --              fix last spell
keymap("n", "<leader>j", "i<c-g>u<Esc>]s1z=`]a<c-g>u<esc>", opts) --    fix next spell
keymap("n", "<leader>k", "i<c-g>u<Esc>[s1z=`]a<c-g>u<esc>", opts) --    fix prev spell
keymap("n", "]<leader>", "mxo<esc>`x", opts) --       	               break line down
keymap("n", "gG", "<cmd>%y<cr>", opts) --            	                yank full buffer
keymap("n", "<leader><c-q>", "<cmd>qa!<cr>", opts) -- 	             force exit neovim
keymap("x", "gG", "VGOgg", opts) --                   	            select full buffer
keymap("n", "<leader>L", "<cmd>Lazy<cr>", opts) --    	            Lazy plugin status
keymap("n", "y<leader>", "^f:llyE", opts) --           	          yank secret password
keymap({ "n", "x" }, "<c-w><c-e>", "<cmd>vnew<cr>", opts) -- new buffer vertical split
keymap("n", "<c-q>", "<cmd>qa<cr>", opts) -- 	 exit vim safely (vim: not used, or used for terminal control flow, visual block)
keymap({ "n", "x" }, "<c-z>", "<cmd>echo 'Be careful!'<cr>", opts) -- (vim: suspend program (or start new shell))
keymap("n", "<leader>n", '<cmd>lua toggle_file_in_split("~/notes/scratch/main.md")<cr>', opts) -- toggle scratch file

-- QUICK FIX LIST =================================
keymap("n", "<leader>qo", "<cmd>copen<cr>", opts) --   open quickfix
keymap("n", "<leader>qq", "<cmd>ccl<cr>", opts) --    close quickfix
keymap("n", "]q", "<cmd>cn<cr>", opts) --      quickfix next element
keymap("n", "[q", "<cmd>cp<cr>", opts) --      quickfix prev element
keymap("n", "]Q", "<cmd>clast<cr>", opts) --   quickfix last element
keymap("n", "[Q", "<cmd>cfirst<cr>", opts) -- quickfix first element

-- LOCATION LIST===================================
keymap("n", "<leader>lo", "<cmd>lopen<cr>", opts) --   open loclist
keymap("n", "<leader>lq", "<cmd>lclose<cr>", opts) -- close loclist
keymap("n", "]l", "<cmd>lne<cr>", opts) --     loclist next element
keymap("n", "[l", "<cmd>lp<cr>", opts) --      loclist prev element
keymap("n", "]L", "<cmd>llast<cr>", opts) --   loclist last element
keymap("n", "[L", "<cmd>lfirst<cr>", opts) -- loclist first element

-- RESIZE WINDOW ==================================
keymap({ "n", "x" }, "<c-p>", "<cmd>resize +6<cr>", opts) --                    resize up (vim: same as "k")
keymap({ "n", "x" }, "<c-n>", "<cmd>resize -6<cr>", opts) --                  resize down (vim: same as "j")
keymap({ "n", "x" }, "<c-h>", "<cmd>vertical resize +6<cr>", opts) -- resize left (vim: same as "h", "<BS>")
keymap({ "n", "x" }, "<c-;>", "<cmd>vertical resize -6<cr>", opts) --                           resize right

-- TAB COMMANDS ===================================
keymap("n", "<leader>.", "<cmd>tabmove +1<cr>", opts) --  tab left
keymap("n", "<leader>,", "<cmd>tabmove -1<cr>", opts) -- tab right
keymap("n", "<leader>>", "<cmd>tablast<cr>", opts) --     tab last
keymap("n", "<leader><", "<cmd>tabfirst<cr>", opts) --   tab first
keymap("n", "<leader>y", "<cmd>tabclose<cr>", opts) --   tab close

-- OPTIONS ========================================
keymap({ "n", "x" }, "<leader>p", "<cmd>set spell!<cr>", opts)
keymap({ "n", "x" }, "<leader>a", "<cmd>set wrap!<cr>", opts)
keymap({ "n", "x" }, "<leader>b", "<cmd>set nu!<cr>", opts)
keymap("i", "<c-g><c-p>", "<cmd>set spell!<cr>", opts)
keymap("i", "<c-g><c-a>", "<cmd>set wrap!<cr>", opts)
keymap("i", "<c-g><c-b>", "<cmd>set nu!<cr>", opts)
