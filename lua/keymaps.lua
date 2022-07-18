-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- <TELESCOPE>
keymap("n", "<leader>i", "<cmd>Telescope find_files theme=ivy winblend=10<CR>", opts)
keymap("n", "<leader>k", "<cmd>Telescope live_grep theme=ivy winblend=10<cr>", opts)
keymap("n", "<leader>dk", "<cmd>Telescope grep_string theme=ivy winblend=10<cr>", opts)
keymap("n", "<leader>o", "<cmd>Telescope oldfiles theme=ivy winblend=10<cr>", opts)
keymap("n", "<leader>p", "<cmd>Telescope projects theme=dropdown winblend=10<cr>", opts)
keymap("n", "<leader>e", "<cmd>Telescope buffers theme=dropdown winblend=10<cr>", opts)
keymap("n", "<leader>m", "<cmd>Telescope marks theme=ivy winblend=10<cr>", opts)
keymap("n", "<leader>dp", "<cmd>Telescope colorscheme theme=ivy<cr>", opts)
keymap("n", "<leader>dh", "<cmd>Telescope heading theme=dropdown<cr>", opts)
keymap(
	"n",
	"<leader>dg",
	"<cmd>lua require'telescope.builtin'.symbols{ sources = {'emoji', 'kaomoji', 'gitmoji'} }<cr>",
	opts
)

-- <NVIM TREE>
keymap("n", "<leader>r", "<cmd>NvimTreeToggle <cr>", opts)

-- <MAXIMIZER>
keymap("n", "<leader>a", "<cmd>MaximizerToggle!<cr>", opts)

-- <DIFF VIEW GIT>
keymap("n", "<leader>dd", "<cmd>DiffviewOpen<cr>", opts)
keymap("n", "<leader>df", "<cmd>DiffviewFileHistory %<cr>", opts)

-- <CYBU BUFFER NAVIGATION>
keymap("n", "<c-k>", "<plug>(CybuLastusedPrev)", opts)
keymap("n", "<c-j>", "<plug>(CybuLastusedNext)", opts)

keymap("n", "K", "<plug>(CybuPrev)", opts)
keymap("n", "J", "<plug>(CybuNext)", opts)

-- <BUFFER DELETE>
keymap("n", "<c-h>", "<cmd>Bdelete<CR>", opts) -- close buffer without closing window.

-- <CENTERPAD>
keymap("n", "<leader>z", "<cmd>Centerpad<cr>", opts)

-- <TREESITTER UNIT>
keymap("x", "ij", ':lua require"treesitter-unit".select()<CR>', opts)
keymap("o", "ij", ':<c-u>lua require"treesitter-unit".select()<CR>', opts)
keymap("x", "aj", ':lua require"treesitter-unit".select(true)<CR>', opts)
keymap("o", "aj", ':<c-u>lua require"treesitter-unit".select(true)<CR>', opts)

-- <CALENDAR>
keymap("n", "<leader>y", "<cmd>Calendar<CR>", opts)

-- <COLOR PICKER>
keymap("n", "<C-c>", "<cmd>PickColor<cr>", opts)
keymap("i", "<C-c>", "<cmd>PickColorInsert<cr>", opts)

-- <TRANSPARENCY>
keymap("n", "<leader><cr>", "<cmd>TransparentToggle<cr>", opts) -- gives info about current buffer

-- NAVIGATION
keymap("n", "<c-f>", "<c-e>", opts) -- page scrolls down one line
keymap("n", "<c-e>", "<c-y>", opts) -- page scrolls up one line
keymap("n", "<c-v>", "<c-f>", opts) -- fullscreen
keymap("n", "<c-p>", "<c-b>", opts) -- fullscreen
keymap("n", "<c-r>", "<c-w>w", opts) -- navigate through windows
keymap("n", "<c-a>", "<c-w>W", opts) -- navigate through windows

-- RESIZE WINDOW
keymap("n", "å", "<cmd>vertical resize +4<cr>", opts)
keymap("n", "∂", "<cmd>resize +4<cr>", opts)
keymap("n", "ß", "<cmd>resize -4<cr>", opts)
keymap("n", "ƒ", "<cmd>vertical resize -4<cr>", opts)
keymap("n", "<leader><leader>", "<c-w>=", opts) -- center windows

-- INSERT MODE
keymap("i", "<c-e>", "<c-o>$", opts) -- goes end of the line and insert mode again
keymap("i", "<c-f>", "<c-i>", opts) -- tab
keymap("i", "<c-k>", "<c-d>", opts) -- move whole line left
keymap("i", "<c-l>", "<c-t>", opts) -- move whole line right
keymap("i", "<c-o>", "<esc>O", opts) -- go to upper line insert mode
keymap("i", "<c-v>", "<c-r>*", opts) -- paste last registered yank
keymap("i", "<tab>", "<c-f>", opts) -- move line in the correspondng tab frame

-- UTILS
keymap("n", "<c-q>", "<c-r>", opts) -- redo
keymap("n", "<leader>w", "<cmd>set hlsearch!<CR>", opts) -- highlights
keymap("n", "<Leader>f", "<cmd>w<cr>", opts) -- save file
keymap("n", "<Leader>q", "<cmd>q<cr>", opts) -- close window
keymap("n", "<Leader>Q", "<cmd>q!<cr>", opts) -- close window and file
keymap("n", "<Leader>s", "<cmd>call CleanNoNameEmptyBuffers()<cr>", opts) -- clean no name buffers
keymap("n", "<Leader>j", "zz", opts) -- center text
keymap("n", "<Leader>g", "gt", opts) -- next tab
keymap("n", "<Leader>t", "gT", opts) -- prev tab
keymap("n", "<Leader>dt", "<cmd>tabnew %<cr>", opts) -- new tab
keymap("n", "<Leader>u", "<cmd>tabclose<cr>", opts) -- close current tab
keymap("n", "<c-s>", "<cmd>StartupTime<cr>", opts) -- StartupTime
keymap("n", "S", "mzJ`z", opts) -- cursor stay current position when J
keymap("n", "V", "vg_", opts) -- visual to the right
keymap("n", "vv", "Vg_", opts) -- visual whole line
keymap("n", "<c-l>", "<c-v>", opts) -- block visual selection
keymap("n", "zl", "z6l", opts) -- zoom left
keymap("n", "zh", "z6h", opts) -- zoom right
keymap("v", "zl", "z6l", opts) -- zoom left
keymap("v", "zh", "z6h", opts) -- zoom right
keymap("n", "d<leader>", "cc<esc>", opts) -- clear line without deleting break
keymap("n", "<leader>c", "<c-g>", opts) -- gives info about current buffer

-- VIM MAPPING
vim.cmd([[
  " <TELESCOPE>
  vnoremap <silent><leader>i "zy:Telescope find_files default_text=<C-r>z<cr>
  vnoremap <silent><leader>k "zy:Telescope live_grep default_text=<C-r>z theme=ivy<cr>

  " <LUASNIP>
  snoremap p p
  snoremap <c-h> <BS>i
  nnoremap <leader>da <CMD>LuaSnipUnlinkCurrent<CR>

  " Move line/paragraph
  vnoremap <silent><c-j> :m '>+1<cr>gv=gv
  vnoremap <silent><c-k> :m '<-2<cr>gv=gv

  " Switching record macro and yank key
  nnoremap q y
  vnoremap q y
  nnoremap Q y+
  vnoremap Q y+
  nnoremap qq yy
  nnoremap y q

  " Activate lua settings
  nnoremap <leader>do :so %<cr>

  " Center horizontal
  nnoremap <silent> z. :<C-u>normal! zszH<CR>

  " Sessions
  nnoremap <leader>dj :mksession! ~/sessions/
  nnoremap <leader>ds :source ~/sessions/

  " Command Substitution
  nnoremap \ [
  nnoremap ^ ]
  vnoremap \ [
  vnoremap ^ ]
]])

-- COMMAND SUBSTITUTION
-- Q
keymap("n", "&", "#", opts)
keymap("v", "&", "#", opts)
keymap("n", "d&", "d#", opts)
keymap("n", "q&", "y#", opts)
-- W, E are the same
-- R
keymap("n", "+", "{", opts)
keymap("v", "+", "{", opts)
keymap("n", "d+", "d{", opts)
keymap("n", "q+", "y{", opts)
-- T
keymap("n", "*", "-", opts)
keymap("v", "*", "-", opts)
keymap("n", "d*", "d-", opts)
keymap("n", "q*", "y-", opts)
-- U
keymap("n", "#", "+", opts)
keymap("v", "#", "+", opts)
keymap("n", "d#", "d+", opts)
keymap("n", "q#", "y+", opts)
-- I
keymap("n", "$", "(", opts)
keymap("v", "$", "(", opts)
keymap("n", "d$", "d(", opts)
keymap("n", "q$", "y(", opts)
-- O
keymap("n", "%", ")", opts)
keymap("v", "%", ")", opts)
keymap("n", "d%", "d)", opts)
keymap("n", "q%", "y)", opts)
-- A
keymap("n", "(", "*", opts)
keymap("v", "(", "*", opts)
keymap("n", "d(", "d*", opts)
keymap("n", "q(", "y*", opts)
-- S
keymap("n", "{", "@", opts)
keymap("v", "{", "@", opts)
-- D is the same
-- F
keymap("n", "-", "}", opts)
keymap("v", "-", "}", opts)
keymap("n", "d-", "d}", opts)
keymap("n", "q-", "y}", opts)
-- G
keymap("n", "[", "$", opts)
keymap("v", "[", "$", opts)
keymap("n", "d[", "d$", opts)
keymap("n", "q[", "y$", opts)
-- H
keymap("n", "]", "==", opts)
keymap("v", "]", "==", opts)
-- J
keymap("n", "=", "%", opts)
keymap("v", "=", "%", opts)
keymap("n", "d=", "d%", opts)
keymap("n", "q=", "y%", opts)
-- K
keymap("n", "}", "&", opts)
-- Z
keymap("n", "!", "|", opts)
keymap("v", "!", "|", opts)
keymap("n", "d!", "|", opts)
keymap("n", "q!", "|", opts)
-- C, V are the same
-- B
keymap("n", "@", "!", opts)
-- N
keymap("n", "}", "~", opts)
keymap("v", "}", "~", opts)
keymap("n", "d}", "d~", opts)
-- M
keymap("n", ")", "^", opts)
keymap("v", ")", "^", opts)
keymap("n", "d)", "d^", opts)
keymap("n", "q)", "q^", opts)
