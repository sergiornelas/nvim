-- Equivalent: <c-i> and <Tab>, <c-m> and <CR> (enter), <c-j> and <NL> (new line), <c-h> and backspace

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
map("n", "<leader>sp", "<cmd>Telescope colorscheme theme=ivy<cr>")
map("n", "<leader>p", "<cmd>Telescope projects theme=ivy<cr>")
map("n", "<leader>m", "<cmd>Telescope marks theme=ivy<cr>")
map("n", "<leader>:", "<cmd>Telescope commands theme=ivy<cr>")

-- <NVIM TREE>
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")

-- <MAXIMIZER>
map("n", "<leader>a", "<cmd>MaximizerToggle!<cr>")

-- <DIFF VIEW GIT>
map("n", "<leader>sd", "<cmd>DiffviewOpen<cr>")

-- <BUFFER NAVIGATION>
map("n", "<c-j>", "<cmd>BufferLineCyclePrev<cr>") --previous buffer
map("n", "<c-k>", "<cmd>BufferLineCycleNext<cr>") --next buffer
map("n", "<c-t>", "<cmd>Bdelete<CR>") --close buffer without closing window.
map("n", "ƒ", "<cmd>BufferLineMoveNext<CR>") --move buffer tap to next
map("n", "å", "<cmd>BufferLineMovePrev<CR>") --move buffer tap to prev

-- <TOGGLE TRANSPARENCY>
map("n", "<leader>z", "<cmd>TransparentToggle<cr>")

-- RESIZE WINDOW
map("n", "˙", "<cmd>vertical resize +4<cr>") --resize window horizontal
map("n", "∆", "<cmd>resize +4<cr>") --resize window vertical
map("n", "˚", "<cmd>resize -4<cr>") --resize window vertical
map("n", "¬", "<cmd>vertical resize -4<cr>") --resize window horizontal
map("n", "<leader>d", "<cmd>set hlsearch!<cr>") --highlights

-- WINDOW NAVIGATION
map("n", "<c-h>", "<cmd>wincmd h<cr>") --move left window
map("n", "<c-n>", "<cmd>wincmd j<cr>") --move below window
map("n", "<c-p>", "<cmd>wincmd k<cr>") --move upper window
map("n", "<c-l>", "<cmd>wincmd l<cr>") --move right window

-- UTILS
map("n", "<Leader>r", "<cmd>w<cr>") --save file
map("n", "<Leader>q", "<cmd>q<cr>") --quit file
map("n", "<Leader>ww", "<cmd>qa<cr>") --quit all files
map("n", "<c-c><c-c>", "<cmd>qa!<cr>") --close nvim no restrictions
map("n", "<Leader>j", "zz") --center text
map("n", "<Leader>u", "<cmd>tabclose<cr>") --close current tab
map("n", "<c-s>", "<cmd>StartupTime<cr>") --close current tab
map("n", "V", "vg_") --visual to the right
map("n", "vv", "Vg_") --visual whole line
map("n", "J", "mzJ`z") --cursor stay current position when J
map("n", "<Leader>g", "gt") --next tab
map("n", "<Leader>t", "gT") --prev tab
map("n", "<Leader>st", "<cmd>tabnew %<cr>") --new tab

-- HARD TO MAP
vim.cmd([[
  " nnoremap <Leader>j :let &scrolloff=999-&scrolloff<CR>
  inoremap <c-n> <cmd>:m .+1<cr>
  inoremap <c-p> <cmd>:m .-2<cr>
  vnoremap <c-n> :m '>+1<cr>gv=gv
  vnoremap <c-p> :m '<-2<cr>gv=gv

  nnoremap <leader>so :so %<cr>

  nnoremap <leader>sh :mksession! ~/sessions/
  nnoremap <leader>sj :source ~/sessions/

  autocmd TermEnter term://*toggleterm#*
        \ tnoremap <silent><c-g> <Cmd>exe v:count1 . "ToggleTerm"<cr>
  nnoremap <silent><c-g> <Cmd>exe v:count1 . "ToggleTerm"<cr>
  inoremap <silent><c-g> <Esc><Cmd>exe v:count1 . "ToggleTerm"<cr>

  snoremap <c-h> <BS>i

  nnoremap <leader>ss <CMD>LuaSnipUnlinkCurrent<CR>

  nnoremap <leader>sl :lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>
]])

-- AVOID UNPRACTICAL YANKING
-- map("v", "p", '"_dP') --Pasting without yanking
-- map("v", "P", '"_dP') --Pasting without yanking
