-- Equivalent: <c-i> and <Tab>, <c-m> and <CR> (enter), <c-j> and <NL> (new line), <c-h> and backspace
-- :help key-notation

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
map("n", "<leader>k", "<cmd>Telescope buffers theme=ivy<cr>")
map("n", "<leader>f", "<cmd>Telescope find_files theme=ivy<cr>")
map("n", "<leader>l", "<cmd>Telescope live_grep theme=ivy<cr>")
map("n", "<leader>o", "<cmd>Telescope oldfiles theme=ivy<cr>")
map("n", "<leader>p", "<cmd>Telescope projects theme=ivy<cr>")
map("n", "<leader>m", "<cmd>Telescope marks theme=ivy<cr>")
map("n", "<leader>sl", "<cmd>Telescope grep_string theme=ivy<cr>")

-- <NVIM TREE>
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")

-- <MAXIMIZER>
map("n", "<leader>a", "<cmd>MaximizerToggle!<cr>")

-- <DIFF VIEW GIT>
map("n", "<leader>sd", "<cmd>DiffviewOpen<cr>")
map("n", "<leader>sf", "<cmd>DiffviewFileHistory<cr>")

-- <BUFFER NAVIGATION>
map("n", "<c-n>", "<cmd>BufferLineCyclePrev<cr>") --previous buffer
map("n", "<c-m>", "<cmd>BufferLineCycleNext<cr>") --next buffer
map("n", "<c-c>", "<cmd>Bdelete<CR>") --close buffer without closing window.
map("n", "ƒ", "<cmd>BufferLineMoveNext<CR>") --move buffer tap to next
map("n", "å", "<cmd>BufferLineMovePrev<CR>") --move buffer tap to prev

-- <CALENDAR>
map("n", "<leader>s;", "<cmd>Calendar<CR>") --move buffer tap to prev

-- AVOID UNPRACTICAL YANKING
map("v", "p", '"_dP') --Pasting without yanking
map("v", "P", '"_dP') --Pasting without yanking

-- RESIZE WINDOW
map("n", "˙", "<cmd>vertical resize +4<cr>") --resize window horizontal
map("n", "∆", "<cmd>resize +4<cr>") --resize window vertical
map("n", "˚", "<cmd>resize -4<cr>") --resize window vertical
map("n", "¬", "<cmd>vertical resize -4<cr>") --resize window horizontal
map("n", "<leader>d", "<cmd>set hlsearch!<cr>") --highlights
map("n", "<leader><leader>", "<c-w>=") --center windows

-- WINDOW NAVIGATION
map("n", "<c-h>", "<cmd>wincmd h<cr>") --move left window
map("n", "<c-j>", "<cmd>wincmd j<cr>") --move below window
map("n", "<c-k>", "<cmd>wincmd k<cr>") --move upper window
map("n", "<c-l>", "<cmd>wincmd l<cr>") --move right window

-- UTILS
map("n", "<Leader>r", "<cmd>w<cr>") --save file
map("n", "<Leader>q", "<cmd>q<cr>") --quit file
map("n", "<Leader>ww", "<cmd>qa<cr>") --quit all files
map("n", "<c-q><c-q>", "<cmd>qa!<cr>") --close nvim no restrictions
map("n", "<Leader>j", "zz") --center text
map("n", "<Leader>u", "<cmd>tabclose<cr>") --close current tab
map("n", "<c-s>", "<cmd>StartupTime<cr>") --close current tab
map("n", "V", "vg_") --visual to the right
map("n", "vv", "Vg_") --visual whole line
map("n", "J", "mzJ`z") --cursor stay current position when J
map("n", "<Leader>g", "gt") --next tab
map("n", "<Leader>t", "gT") --prev tab
map("n", "<Leader>st", "<cmd>tabnew %<cr>") --new tab
map("n", "<Leader>we", "<cmd>call CleanNoNameEmptyBuffers()<cr>") --new tab
map("n", "<c-p>", "<c-y>") --page scrolls up one line

-- VIM MAPPING
vim.cmd([[
  vnoremap <c-j> :m '>+1<cr>gv=gv
  vnoremap <c-k> :m '<-2<cr>gv=gv

  nnoremap <leader>so :so %<cr>

  " SESSIONS
  nnoremap <leader>wj :mksession! ~/sessions/
  nnoremap <leader>sj :source ~/sessions/

  " <TRANSPARENCY>
  nnoremap <leader>; :TransparentToggle

  " <NEORG>
  nnoremap <leader>nw :Neorg workspace 

  " <LUASNIP>
  snoremap <c-h> <BS>i
  nnoremap <leader>ss <CMD>LuaSnipUnlinkCurrent<CR>

  " <TELESCOPE>
  nnoremap <silent><leader>sb :lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>
  nnoremap <silent><leader>sp :lua require("plugins.telescope").choose_colors()<cr>
  vnoremap <silent><leader>L "zy:Telescope live_grep default_text=<C-r>z<cr>
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
