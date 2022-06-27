-- Helper function for clean mappings
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " " --Leader

-- <TELESCOPE>
map("n", "<leader>i", "<cmd>Telescope find_files theme=ivy<cr>")
map("n", "<leader>l", "<cmd>Telescope live_grep theme=ivy<cr>")
map("n", "<leader>sl", "<cmd>Telescope grep_string theme=ivy<cr>")
map("n", "<leader>o", "<cmd>Telescope oldfiles theme=ivy<cr>")
map("n", "<leader>p", "<cmd>Telescope project theme=dropdown layout_config={width=0.16}<cr>")
map("n", "<leader>k", "<cmd>Telescope buffers theme=dropdown<cr>")
map("n", "<leader>m", "<cmd>Telescope marks theme=ivy<cr>")

-- <NVIM TREE>
map("n", "<leader>e", "<cmd>NvimTreeToggle <cr>")

-- <MAXIMIZER>
map("n", "<leader>a", "<cmd>MaximizerToggle!<cr>")

-- <DIFF VIEW GIT>
map("n", "<leader>sd", "<cmd>DiffviewOpen<cr>")
map("n", "<leader>sf", "<cmd>DiffviewFileHistory %<cr>")

-- <BUFFER NAVIGATION>
-- map("n", "<c-j>", "<cmd>BufferLineCyclePrev<cr>") --previous buffer
-- map("n", "<c-k>", "<cmd>BufferLineCycleNext<cr>") --next buffer
map("n", "<c-h>", "<cmd>Bdelete<CR>") --close buffer without closing window.
map("n", "®", "<cmd>BufferLineMoveNext<CR>") --move buffer tap to next
map("n", "∑", "<cmd>BufferLineMovePrev<CR>") --move buffer tap to prev

-- <CALENDAR>
map("n", "<leader><cr>", "<cmd>Calendar<CR>") --move buffer tap to prev

-- <LSP>
map("n", "du", "<cmd>LspDiagPrev<CR>") --move buffer tap to prev
map("n", "dm", "<cmd>LspDiagNext<CR>") --move buffer tap to prev

-- AVOID UNPRACTICAL YANKING
map("v", "p", '"_dP') --Pasting without yanking
map("v", "P", '"_dP') --Pasting without yanking

-- NAVIGATION
map("n", "<c-f>", "<c-e>") --page scrolls down one line
map("n", "<c-e>", "<c-y>") --page scrolls up one line
map("n", "<c-v>", "<c-f>") --fullscreen
map("n", "<c-p>", "<c-b>") --fullscreen
map("n", "<c-a>", "<c-w>w") --navigate through windows
map("n", "<c-q>", "<c-w>W") --navigate through windows

-- RESIZE WINDOW
map("n", "å", "<cmd>vertical resize +4<cr>") --resize window horizontal
map("n", "∂", "<cmd>resize +4<cr>") --resize window vertical
map("n", "ß", "<cmd>resize -4<cr>") --resize window vertical
map("n", "ƒ", "<cmd>vertical resize -4<cr>") --resize window horizontal
map("n", "<leader><leader>", "<c-w>=") --center windows

-- UTILS
map("n", "<leader>d", "<cmd>set hlsearch!<cr>") --highlights
map("n", "<Leader>f", "<cmd>w<cr>") --save file
map("n", "<Leader>q", "<cmd>q<cr>") --close window
map("n", "<Leader>Q", "<cmd>q!<cr>") --close window and file
map("n", "<Leader>ww", "<cmd>qa<cr>") --quit all saved buffers and exit
map("n", "<c-c><c-c>", "<cmd>qa!<cr>") --close nvim no restrictions
map("n", "<Leader>j", "zz") --center text
map("n", "<Leader>u", "<cmd>tabclose<cr>") --close current tab
map("n", "<c-s>", "<cmd>StartupTime<cr>") --StartupTime
map("n", "V", "vg_") --visual to the right
map("n", "vv", "Vg_") --visual whole line
map("n", "J", "mzJ`z") --cursor stay current position when J
map("n", "<Leader>g", "gt") --next tab
map("n", "<Leader>t", "gT") --prev tab
map("n", "<Leader>st", "<cmd>tabnew %<cr>") --new tab
map("n", "<Leader>we", "<cmd>call CleanNoNameEmptyBuffers()<cr>") --clean no name buf
map("i", "<c-v>", "<c-o>$") --insert mode goes end of the line and insert mode again
map("i", "<c-q>", "<c-t>") --tab line insert mode
map("n", "zl", "z6l") --zoom left
map("n", "zh", "z6h") --zoom right
map("v", "zl", "z6l") --zoom left
map("v", "zh", "z6h") --zoom right
map("n", "d<leader>", "cc<esc>") --clear line without deleting line
map("i", "<c-o>", "<esc>O") --clear line without deleting line
map("n", "<leader>c", "<c-g>") --clear line without deleting line

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
  nnoremap <leader>so :so %<cr>

  "Center horizontal
  nnoremap <silent> z. :<C-u>normal! zszH<CR>

  "Command Substitution
  nnoremap \ [
  nnoremap ^ ]
  vnoremap \ [
  vnoremap ^ ]

  "SESSIONS
  nnoremap <leader>wj :mksession! ~/sessions/
  nnoremap <leader>ss :source ~/sessions/

  "<TRANSPARENCY>
  nnoremap <leader>r :TransparentToggle<CR>

  "<NEORG>
  nnoremap <leader>nw :Neorg workspace 

  "<LUASNIP>
  snoremap p p
  snoremap <c-h> <BS>i
  nnoremap <leader>sj <CMD>LuaSnipUnlinkCurrent<CR>

  "<TELESCOPE>
  " nnoremap <silent><leader>sp :lua require("plugins.telescope").choose_colors()<cr>
  nnoremap <silent><leader>sp :lua require("plugins.telescope").choose_colors()<cr>
  nnoremap <silent><leader>b :lua require('telescope.builtin').live_grep({grep_open_files=true}) print('Current Buffers')<CR>
  vnoremap <silent><leader>l "zy:Telescope live_grep default_text=<C-r>z theme=ivy<cr>
  vnoremap <silent><leader>f "zy:Telescope find_files default_text=<C-r>z<cr>
]])

-- TREESITTER UNIT
vim.api.nvim_set_keymap("x", "ij", ':lua require"treesitter-unit".select()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("o", "ij", ':<c-u>lua require"treesitter-unit".select()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "aj", ':lua require"treesitter-unit".select(true)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap(
	"o",
	"aj",
	':<c-u>lua require"treesitter-unit".select(true)<CR>',
	{ noremap = true, silent = true }
)

-- COMMAND SUBSTITUTION
-- Q
map("n", "&", "#")
map("v", "&", "#")
map("n", "d&", "d#")
map("n", "q&", "y#")
-- W
map("n", "?", ";")
map("v", "?", ";")
map("n", "d?", "d;")
map("n", "q?", "y;")
-- E is the same
-- R
map("n", "+", "@")
map("v", "+", "@")
-- T
map("n", "*", "-")
map("v", "*", "-")
map("n", "d*", "d-")
map("n", "q*", "y-")
-- U
map("n", "#", "+")
map("v", "#", "+")
map("n", "d#", "d+")
map("n", "q#", "y+")
-- I
map("n", "$", "(")
map("v", "$", "(")
map("n", "d$", "d(")
map("n", "q$", "y(")
-- O
map("n", "%", ")")
map("v", "%", ")")
map("n", "d%", "d)")
map("n", "q%", "y)")
-- A
map("n", "(", "*")
map("v", "(", "*")
map("n", "d(", "d*")
map("n", "q(", "y*")
-- S
map("n", "{", "?")
map("v", "{", "?")
map("n", "d{", "d?")
map("n", "q{", "y?")
-- D
map("n", ";", "{")
map("v", ";", "{")
map("n", "d;", "d{")
map("n", "q;", "y{")
-- F
map("n", "-", "}")
map("v", "-", "}")
map("n", "d-", "d}")
map("n", "q-", "y}")
-- G
map("n", "[", "$")
map("v", "[", "$")
map("n", "d[", "d$")
map("n", "q[", "y$")
-- H
map("n", "]", "=")
map("v", "]", "=")
-- J
map("n", "=", "%")
map("v", "=", "%")
map("n", "d=", "d%")
map("n", "q=", "y%")
-- K
map("n", "}", "&")
-- Z
map("n", "!", "|")
map("v", "!", "|")
map("n", "d!", "|")
map("n", "q!", "|")
-- C, V are the same
-- B
map("n", "@", "!")
-- N
map("n", "}", "~")
map("v", "}", "~")
map("n", "d}", "d~")
-- M
map("n", ")", "^")
map("v", ")", "^")
map("n", "d)", "d^")
map("n", "q)", "q^")
