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
map("n", "<c-j>", "<cmd>Telescope buffers theme=ivy<cr>")
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
map("n", "<c-k>", "<cmd>BufferLineCyclePrev<cr>") --previous buffer
map("n", "<c-l>", "<cmd>BufferLineCycleNext<cr>") --next buffer
map("n", "<c-c>", "<cmd>Bdelete<CR>") --close buffer without closing window.
map("n", "®", "<cmd>BufferLineMoveNext<CR>") --move buffer tap to next
map("n", "∑", "<cmd>BufferLineMovePrev<CR>") --move buffer tap to prev

-- <CALENDAR>
map("n", "<leader>;", "<cmd>Calendar<CR>") --move buffer tap to prev

-- AVOID UNPRACTICAL YANKING
map("v", "p", '"_dP') --Pasting without yanking
map("v", "P", '"_dP') --Pasting without yanking

-- RESIZE WINDOW
map("n", "å", "<cmd>vertical resize +4<cr>") --resize window horizontal
map("n", "∂", "<cmd>resize +4<cr>") --resize window vertical
map("n", "ß", "<cmd>resize -4<cr>") --resize window vertical
map("n", "ƒ", "<cmd>vertical resize -4<cr>") --resize window horizontal
map("n", "<leader><leader>", "<c-w>=") --center windows

-- UTILS
map("n", "<leader>d", "<cmd>set hlsearch!<cr>") --highlights
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
map("v", "<c-p>", "<c-y>") --page scrolls up one line
map("i", "<c-g>", "<c-o>$") --insert mode goes end of the line and insert mode again

-- REPLACE Y yanking to Q
map("n", "y", "q") --replace q to y for start macro
map("n", "q", "y") --replace y to q for yanking
map("v", "y", "q") --replace q to y for start macro
map("v", "q", "y") --replace y to q for yanking
map("n", "qq", "yy") --replace y to q for yanking
map("v", "qq", "yy") --replace y to q for yanking

-- COMMAND SUBSTITUTION
map("n", "(", "^")
map("n", "d(", "d^")
map("n", "q(", "y^")
map("v", "(", "^")
map("n", ")", "#")
map("n", "d)", "d#")
map("n", "q)", "y#")
map("v", ")", "#")
map("n", "}", "$")
map("n", "d}", "d$")
map("n", "q}", "y$")
map("v", "}", "$")
map("n", "-", "}")
map("n", "d-", "d}")
map("n", "q-", "y}")
map("v", "-", "}")
map("n", "+", "=")
map("n", "=", "%")
map("n", "d=", "d%")
map("n", "q=", "y%")
map("v", "=", "%")
map("n", "%", "(")
map("n", "d%", "d(")
map("n", "q%", "y(")
map("v", "%", "(")
map("n", "_", ")")
map("n", "d_", "d)")
map("n", "q_", "y)")
map("v", "_", ")")

-- VIM MAPPING
vim.cmd([[
  vnoremap <silent><c-j> :m '>+1<cr>gv=gv
  vnoremap <silent><c-k> :m '<-2<cr>gv=gv

  nnoremap <leader>so :so %<cr>

  " SESSIONS
  nnoremap <leader>wj :mksession! ~/sessions/
  nnoremap <leader>sj :source ~/sessions/

  " <TRANSPARENCY>
  nnoremap <leader>s; :TransparentToggle<CR>

  " <NEORG>
  nnoremap <leader>nw :Neorg workspace 

  " <LUASNIP>
  snoremap <c-h> <BS>i
  nnoremap <leader>ss <CMD>LuaSnipUnlinkCurrent<CR>

  " <TELESCOPE>
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

-- WINDOW NAVIGATION
-- map("n", "<c-h>", "<cmd>wincmd h<cr>") --move left window
-- map("n", "<c-j>", "<cmd>wincmd j<cr>") --move below window
-- map("n", "<c-k>", "<cmd>wincmd k<cr>") --move upper window
-- map("n", "<c-l>", "<cmd>wincmd l<cr>") --move right window
