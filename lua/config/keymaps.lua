vim.g.mapleader = " "
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- LEADER MAPS ====================================
keymap("n", "<leader>L", "<cmd>Lazy<cr>", opts)
keymap("n", "<leader>>", "<cmd>tabmove +1<cr>", opts) --               tab left
keymap("n", "<leader><", "<cmd>tabmove -1<cr>", opts) --              tab right
keymap("n", "<leader>?", "<cmd>tabclose<cr>", opts) --                tab close
keymap("n", "<leader>w", "<cmd>w<cr>", opts) --                       save file
keymap("", "<leader>h", "<cmd>set hlsearch!<cr>", opts) --           highlights
keymap("n", "d<leader>", "cc<esc>", opts) --                         clear line
keymap("", "<leader>W", "<cmd>set wrap!<cr>", opts) --          toggle set wrap
keymap("", "<leader>S", "<cmd>set spell!<cr>", opts) --        toggle set spell
keymap("", "<leader>N", "<cmd>set nu!<cr>", opts) --          toggle set number
keymap("n", "y<leader>", "$T!yt!", opts) --                yank secret password
keymap("n", "<leader><c-q>", "<cmd>qa!<cr>", opts) --         force exit neovim
keymap("n", "<leader>i", function() --                              inlay hints
	vim.lsp.inlay_hint(0, nil)
end, opts)
-- MAPS ===========================================
keymap("", "<Up>", "<cmd>resize -4<cr>", opts) --                     resize up
keymap("", "<Down>", "<cmd>resize +4<cr>", opts) --                 resize down
keymap("", "<Left>", "<cmd>vertical resize -4<cr>", opts) --        resize left
keymap("", "<Right>", "<cmd>vertical resize +4<cr>", opts) --      resize right
keymap("n", "g<c-k>", "mxO<esc>`x", opts) --                      break line up
keymap("n", "g<c-j>", "mxo<esc>`x", opts) --                    break line down
keymap("n", "gG", "<cmd>%y+<cr>", opts) --                     yank full buffer
keymap("x", "gG", "VGOgg", opts) --                          select full buffer
keymap({ "n", "x" }, "<c-z>", "<cmd>echo 'Be careful!'<cr>", opts) -- stop exit
keymap("n", "<c-q>", "<cmd>qa<cr>", opts) -- (vim: not used, or used for terminal control flow)
