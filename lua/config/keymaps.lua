vim.g.mapleader = " "
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<leader>w", "<cmd>w<cr>", opts) --               save file
keymap("", "<leader>h", "<cmd>set hlsearch!<cr>", opts) --   highlights
keymap("n", "d<leader>", "cc<esc>", opts) --                 clear line
keymap("n", "<leader>L", "<cmd>Lazy<cr>", opts) --          Lazy status
keymap("n", "y<leader>", "$T!yt!", opts) --        yank secret password
keymap("n", "<leader><c-q>", "<cmd>qa!<cr>", opts) -- force exit neovim
keymap("n", "[<leader>", "mxO<esc>`x", opts) --           break line up
keymap("n", "]<leader>", "mxo<esc>`x", opts) --         break line down
keymap("n", "gG", "<cmd>%y+<cr>", opts) --             yank full buffer
keymap("x", "gG", "VGOgg", opts) --                  select full buffer
keymap("n", "<leader>i", function() --               switch inlay hints
	vim.lsp.inlay_hint(0, nil)
end, opts)
keymap("n", "<c-q>", "<cmd>qa<cr>", opts) -- exit vim safely (vim: not used, or used for terminal control flow)
keymap({ "n", "x" }, "<c-z>", "<cmd>echo 'Be careful!'<cr>", opts) -- (vim: suspend program (or start new shell))

-- ARG LIST ========================================
-- arglist gets deleted if you open:
-- ~ buffer using drop command
-- ~ file(s) straight from nvim command (not loading auto-session).
keymap("n", "<leader>1", "<cmd>argument 1<cr>", opts) --        go to arg buffer 1
keymap("n", "<leader>2", "<cmd>argument 2<cr>", opts) --        go to arg buffer 2
keymap("n", "<leader>3", "<cmd>argument 3<cr>", opts) --        go to arg buffer 3
keymap("n", "<leader>4", "<cmd>argument 4<cr>", opts) --        go to arg buffer 4
keymap("n", "<leader>5", "<cmd>argument 5<cr>", opts) --        go to arg buffer 5
keymap("n", "<leader>6", "<cmd>argument 6<cr>", opts) --        go to arg buffer 6
keymap("n", "<leader>7", "<cmd>argument 7<cr>", opts) --        go to arg buffer 7
keymap("n", "<leader>aj", "<cmd>args<cr>", opts) --          show arg list buffers
keymap("n", "<leader>ad", "<cmd>argdelete<cr>", opts) --         delete arg buffer
keymap("n", "<leader>ap", "<cmd>argdedupe<cr>", opts) -- delete duplicated buffers
keymap("n", "<leader>an", "<cmd>argadd<cr>", opts) --       add buffer to arg list
keymap("n", "<leader>af", "<cmd>fir<cr>", opts) --           go to fist arg buffer
keymap("n", "<leader>al", "<cmd>la<cr>", opts) --            go to last arg buffer

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
keymap("n", "<c-p>", "<cmd>resize +6<cr>", opts) --            resize up (vim: same as "k")
keymap("n", "<c-n>", "<cmd>resize -6<cr>", opts) --          resize down (vim: same as "j")
keymap("n", "<c-h>", "<cmd>vertical resize +6<cr>", opts) -- resize left (vim: same as "h")
keymap("n", "<c-;>", "<cmd>vertical resize -6<cr>", opts) --                   resize right

-- TOGGLE OPTIONS =================================
keymap("", "<leader>p", "<cmd>set wrap!<cr>", opts) --   toggle set wrap
keymap("", "<leader>S", "<cmd>set spell!<cr>", opts) -- toggle set spell
keymap("", "<leader>N", "<cmd>set nu!<cr>", opts) --   toggle set number

-- TAB ============================================
keymap("n", "<leader>>", "<cmd>tabmove +1<cr>", opts) --  tab left
keymap("n", "<leader><", "<cmd>tabmove -1<cr>", opts) -- tab right
keymap("n", "<leader>?", "<cmd>tabclose<cr>", opts) --   tab close
