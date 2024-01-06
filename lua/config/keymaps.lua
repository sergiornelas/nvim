vim.g.mapleader = " "
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<leader>w", "<cmd>w<cr>", opts) --       	            save file
keymap("n", "d<leader>", "cc<esc>", opts) --          	           clear line
keymap("n", "[<leader>", "mxO<esc>`x", opts) --       	        break line up
keymap("n", "]<leader>", "mxo<esc>`x", opts) --       	      break line down
keymap("n", "gG", "<cmd>%y+<cr>", opts) --            	     yank full buffer
keymap("n", "<leader><c-q>", "<cmd>qa!<cr>", opts) -- 	    force exit neovim
keymap("x", "gG", "VGOgg", opts) --                   	   select full buffer
keymap("n", "<leader>L", "<cmd>Lazy<cr>", opts) --    	   Lazy plugin status
keymap("n", "y<leader>", "$T!yt!", opts) --           	 yank secret password
keymap("n", "<c-w><c-e>", "<cmd>vnew<cr>", opts) -- new buffer vertical split
keymap("n", "<c-q>", "<cmd>qa<cr>", opts) -- 	 exit vim safely (vim: not used, or used for terminal control flow)
keymap({ "n", "x" }, "<c-z>", "<cmd>echo 'Be careful!'<cr>", opts) -- (vim: suspend program (or start new shell))

-- ARG LIST =======================================
-- arglist gets deleted if you open buffer using drop command
keymap("n", "<leader>1", "<cmd>argument 1<cr>", opts) --          go to arg buffer 1
keymap("n", "<leader>2", "<cmd>argument 2<cr>", opts) --          go to arg buffer 2
keymap("n", "<leader>3", "<cmd>argument 3<cr>", opts) --          go to arg buffer 3
keymap("n", "<leader>4", "<cmd>argument 4<cr>", opts) --          go to arg buffer 4
keymap("n", "<leader>5", "<cmd>argument 5<cr>", opts) --          go to arg buffer 5
keymap("n", "<leader>6", "<cmd>argument 6<cr>", opts) --          go to arg buffer 6
keymap("n", "<leader>7", "<cmd>argument 7<cr>", opts) --          go to arg buffer 7
keymap("n", "<leader>aj", "<cmd>args<cr>", opts) --            show arg list buffers
keymap("n", "<leader>ad", "<cmd>argdelete<cr>", opts) --           delete arg buffer
keymap("n", "<leader>ap", "<cmd>argdedupe<cr>", opts) -- delete duplicated filenames
keymap("n", "<leader>m", "<cmd>argadd<cr>", opts) --          add buffer to arg list
keymap("n", "<leader>af", "<cmd>fir<cr>", opts) --             go to fist arg buffer
keymap("n", "<leader>al", "<cmd>la<cr>", opts) --              go to last arg buffer

-- QUICK FIX LIST =================================
keymap("n", "<leader>qj", "<cmd>copen<cr>", opts) --   open quickfix
keymap("n", "<leader>qq", "<cmd>ccl<cr>", opts) --    close quickfix
keymap("n", "]q", "<cmd>cn<cr>", opts) --      quickfix next element
keymap("n", "[q", "<cmd>cp<cr>", opts) --      quickfix prev element
keymap("n", "]Q", "<cmd>clast<cr>", opts) --   quickfix last element
keymap("n", "[Q", "<cmd>cfirst<cr>", opts) -- quickfix first element

-- LOCATION LIST===================================
keymap("n", "<leader>lj", "<cmd>lopen<cr>", opts) --   open loclist
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
keymap("n", "<leader>/", "<cmd>tabclose<cr>", opts) --   tab close

-- TOGGLE OPTIONS =================================
keymap({ "n", "x", "i" }, "<c-g><c-w>", "<cmd>set wrap!<cr>", opts) --   toggle wrap (vim: display current file name and position, toggle between Visual mode and Select mode)
keymap({ "n", "x", "i" }, "<c-g><c-l>", "<cmd>set spell!<cr>", opts) -- toggle spell (vim: display current file name and position, toggle between Visual mode and Select mode)
keymap({ "n", "x", "i" }, "<c-g><c-n>", "<cmd>set nu!<cr>", opts) --   toggle number (vim: display current file name and position, toggle between Visual mode and Select mode)
keymap({ "n", "x", "i" }, "<c-g><c-i>", function()
	if vim.lsp.inlay_hint.is_enabled() then
		vim.lsp.inlay_hint.enable(0, false)
	else
		vim.lsp.inlay_hint.enable(0, true)
	end
end, opts)
