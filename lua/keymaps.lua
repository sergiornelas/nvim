-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- <TELESCOPE>
keymap("n", "<leader>i", "<cmd>Telescope find_files theme=ivy<CR>", opts)
keymap("n", "<leader>k", "<cmd>Telescope live_grep theme=ivy<cr>", opts)
keymap("n", "<leader>dl", "<cmd>Telescope grep_string theme=ivy<cr>", opts)
keymap("n", "<leader>o", "<cmd>Telescope oldfiles theme=ivy<cr>", opts)
keymap("n", "<leader>p", "<cmd>Telescope projects theme=dropdown<cr>", opts)
keymap("n", "<leader>e", "<cmd>Telescope buffers theme=dropdown<cr>", opts)
keymap("n", "<leader>m", "<cmd>Telescope marks theme=ivy<cr>", opts)

-- <NVIM TREE>
keymap("n", "<leader>r", "<cmd>NvimTreeToggle <cr>", opts)

-- <MAXIMIZER>
keymap("n", "<leader>a", "<cmd>MaximizerToggle!<cr>", opts)

-- <DIFF VIEW GIT>
keymap("n", "<leader>dd", "<cmd>DiffviewOpen<cr>", opts)
keymap("n", "<leader>df", "<cmd>DiffviewFileHistory %<cr>", opts)

-- <BUFFER NAVIGATION>
keymap("n", "<c-h>", "<cmd>Bdelete<CR>", opts) --close buffer without closing window.
keymap("n", "®", "<cmd>BufferLineMoveNext<CR>", opts) --move buffer tap to next
keymap("n", "∑", "<cmd>BufferLineMovePrev<CR>", opts) --move buffer tap to prev

-- <CALENDAR>
keymap("n", "<leader>y", "<cmd>Calendar<CR>", opts) --move buffer tap to prev

-- <CYBU BUFFER>
keymap("n", "<c-k>", "<plug>(CybuLastusedPrev)", opts)
keymap("n", "<c-j>", "<plug>(CybuLastusedNext)", opts)

-- <COLOR PICKER>
keymap("n", "<C-c>", "<cmd>PickColor<cr>", opts)
keymap("i", "<C-c>", "<cmd>PickColorInsert<cr>", opts)

-- <CENTERPAD>
keymap("n", "<leader>z", "<cmd>Centerpad<cr>", opts)

-- AVOID UNPRACTICAL YANKING
keymap("v", "p", '"_dP', opts) --Pasting without yanking
keymap("v", "P", '"_dP', opts) --Pasting without yanking

-- NAVIGATION
keymap("n", "<c-f>", "<c-e>", opts) --page scrolls down one line
keymap("n", "<c-e>", "<c-y>", opts) --page scrolls up one line
keymap("n", "<c-v>", "<c-f>", opts) --fullscreen
keymap("n", "<c-p>", "<c-b>", opts) --fullscreen
keymap("n", "<c-r>", "<c-w>w", opts) --navigate through windows
keymap("n", "<c-a>", "<c-w>W", opts) --navigate through windows

-- RESIZE WINDOW
keymap("n", "å", "<cmd>vertical resize +4<cr>", opts) --resize window horizontal
keymap("n", "∂", "<cmd>resize +4<cr>", opts) --resize window vertical
keymap("n", "ß", "<cmd>resize -4<cr>", opts) --resize window vertical
keymap("n", "ƒ", "<cmd>vertical resize -4<cr>", opts) --resize window horizontal
keymap("n", "<leader><leader>", "<c-w>=", opts) --center windows

-- UTILS
keymap("n", "<c-q>", "<c-r>", opts) --navigate through windows
keymap("n", "<leader>w", "<cmd>set hlsearch!<CR>", opts) --highlights
keymap("n", "<Leader>f", "<cmd>w<cr>", opts) --save file
keymap("n", "<Leader>q", "<cmd>q<cr>", opts) --close window
keymap("n", "<Leader>Q", "<cmd>q!<cr>", opts) --close window and file
keymap("n", "<Leader>s", "<cmd>call CleanNoNameEmptyBuffers()<cr>", opts) --clean no name buf
keymap("n", "<Leader>j", "zz", opts) --center text
keymap("n", "<Leader>u", "<cmd>tabclose<cr>", opts) --close current tab
keymap("n", "<c-s>", "<cmd>StartupTime<cr>", opts) --StartupTime
keymap("n", "V", "vg_", opts) --visual to the right
keymap("n", "vv", "Vg_", opts) --visual whole line
keymap("n", "J", "mzJ`z", opts) --cursor stay current position when J
keymap("n", "<Leader>g", "gt", opts) --next tab
keymap("n", "<Leader>t", "gT", opts) --prev tab
keymap("n", "<Leader>dt", "<cmd>tabnew %<cr>", opts) --new tab
keymap("n", "<c-l>", "<c-v>", opts) --block visual selection
keymap("i", "<c-v>", "<c-o>$", opts) --insert mode goes end of the line and insert mode again
keymap("i", "<c-q>", "<c-t>", opts) --tab line insert mode
keymap("n", "zl", "z6l", opts) --zoom left
keymap("n", "zh", "z6h", opts) --zoom right
keymap("v", "zl", "z6l", opts) --zoom left
keymap("v", "zh", "z6h", opts) --zoom right
keymap("n", "d<leader>", "cc<esc>", opts) --clear line without deleting line
keymap("i", "<c-o>", "<esc>O", opts) --clear line without deleting line
keymap("n", "<leader>c", "<c-g>", opts) --clear line without deleting line

-- VIM MAPPING
vim.cmd([[
  "Move line/paragraph
  vnoremap <silent><c-j> :m '>+1<cr>gv=gv
  vnoremap <silent><c-k> :m '<-2<cr>gv=gv

  "Switching macro record and yank key
  nnoremap q y
  vnoremap q y
  nnoremap Q y+
  vnoremap Q y+
  nnoremap qq yy
  nnoremap y q

  "Activate lua settings
  nnoremap <leader>do :so %<cr>

  "Center horizontal
  nnoremap <silent> z. :<C-u>normal! zszH<CR>

  "Command Substitution
  nnoremap \ [
  nnoremap ^ ]
  vnoremap \ [
  vnoremap ^ ]

  "SESSIONS
  nnoremap <leader>dj :mksession! ~/sessions/
  nnoremap <leader>ds :source ~/sessions/

  "<TRANSPARENCY>
  nnoremap <silent><leader><cr> :TransparentToggle<CR>

  "<NEORG>
  nnoremap <leader>nw :Neorg workspace

  "<LUASNIP>
  snoremap p p
  snoremap <c-h> <BS>i
  nnoremap <leader>da <CMD>LuaSnipUnlinkCurrent<CR>

  "<TELESCOPE>
  nnoremap <silent><leader>dp :lua require("plugins.telescope").choose_colors()<cr>
  vnoremap <silent><leader>i "zy:Telescope find_files default_text=<C-r>z<cr>
  vnoremap <silent><leader>k "zy:Telescope live_grep default_text=<C-r>z theme=ivy<cr>
  " nnoremap <silent><leader>l :lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>
  nnoremap <silent><leader>b :lua require('telescope.builtin').live_grep({grep_open_files=true}) print('Current Buffers')<CR>
]])

-- TREESITTER UNIT
keymap("x", "ij", ':lua require"treesitter-unit".select()<CR>', opts)
keymap("o", "ij", ':<c-u>lua require"treesitter-unit".select()<CR>', opts)
keymap("x", "aj", ':lua require"treesitter-unit".select(true)<CR>', opts)
keymap("o", "aj", ':<c-u>lua require"treesitter-unit".select(true)<CR>', opts)

-- COMMAND SUBSTITUTION
-- Q
keymap("n", "&", "#", opts)
keymap("v", "&", "#", opts)
keymap("n", "d&", "d#", opts)
keymap("n", "q&", "y#", opts)
-- W
keymap("n", "?", ";", opts)
keymap("v", "?", ";", opts)
keymap("n", "d?", "d;", opts)
keymap("n", "q?", "y;", opts)
-- E is the same
-- R
keymap("n", "+", "@", opts)
keymap("v", "+", "@", opts)
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
keymap("n", "{", "?", opts)
keymap("v", "{", "?", opts)
keymap("n", "d{", "d?", opts)
keymap("n", "q{", "y?", opts)
-- D
keymap("n", ";", "{", opts)
keymap("v", ";", "{", opts)
keymap("n", "d;", "d{", opts)
keymap("n", "q;", "y{", opts)
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
