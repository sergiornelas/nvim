-- Equivalent:
-- <c-i> and <Tab>
-- <c-m> and <CR> (enter)
-- <c-j> and <NL> (new line)
-- <c-h> and backspace

--             Interesting combos:
-- ["<Leader>j"] = ":buffers<CR>:buffer<Space>",
-- nnoremap <C-a> mzggvvGy`z- (tried to copy all text)
-- ========================================================================================================
-- Don't set alt + i, alt + o, alt + p, they are for moving the window (ubuntu settings)
-- DON'T MAP ANYTHING WITH <leader> THAT SETS IN INSERT MODE
-- ========================================================================================================

-- Helper function for clean mappings
local function map(mode, lhs, rhs, opts)
   local options = { noremap = true, silent = true }
   if opts then
      options = vim.tbl_extend("force", options, opts)
   end
   vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " " --Leader
map("n", ";", ":")    --Semicolon to enter command mode

-- <HOP>
map("n", "<leader>j", "<cmd>HopWord<CR>")
map("n", "<leader>l", "<cmd>HopLine<CR>")

-- <TELESCOPE>
map("n", "<leader>k",       "<cmd>Telescope buffers<cr>")
map("n", "<leader>f",   "<cmd>Telescope find_files<cr>")
map("n", "<leader>st",  "<cmd>Telescope live_grep<cr>")
map("n", "<leader>u",   "<cmd>Telescope oldfiles<cr>")
map("n", "<leader>sp",  "<cmd>Telescope colorscheme<cr>")
map("n", "<leader>p",   "<cmd>Telescope projects<cr>")
map("n", "<leader>m",   "<cmd>Telescope marks<cr>")
map("n", "<leader>:",   "<cmd>Telescope commands<cr>")

-- <NVIM TREE>
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")


-- BUFFER NAVIGATION
map('n', '<c-j>',      '<cmd>bprevious<cr>')                    --previous buffer
map('n', '<c-k>',      '<cmd>bnext<cr>')                        --next buffer
map('n', '<c-t>',      '<cmd>bd<cr>')                           --close buffer

-- RESIZE WINDOW
map('n', '<left>',      '<cmd>vertical resize +4<cr>')          --resize window horizontal
map('n', '<down>',      '<cmd>resize +4<cr>')                   --resize window vertical
map('n', '<up>',      '<cmd>resize -4<cr>')                     --resize window vertical
map('n', '<right>',      '<cmd>vertical resize -4<cr>')         --resize window horizontal

-- CENTER VIEW
map('n', 'n',          'nzzzv')                                 --center view when find next word
map('n', 'N',          'Nzzzv')                                 --center view when find previous word
map('n', '<c-o>',      '<c-o>zz')                               --center view when goes for previous pos.

-- UTILS
map('n', '<Leader>r',  '<cmd>w<cr>')                            --save file
map('n', '<Leader>q',  '<cmd>q<cr>')                            --quit file
map('n', '<Leader>t',  '<cmd>set hlsearch!<cr>')                --toggle highlight
map('n', 'V',          'vg_')                                   --visual to the right
map('n', 'vv',         'Vg_')                                   --visual whole line
map('n', 'J',          'mzJ`z')                                 --cursor stay current position when J
map('v', 'y',          'ygv<esc>')                              --yanking selection don't returns cursor
map('v', 'p',          '"_dP')                                  --Pasting without yanking
map('v', 'P',          '"_dP')                                  --Pasting without yanking
map('n', '<Leader>c',  '<cmd>find ~/.config/nvim/init.lua<cr>') --go to init.lua
map('i', '<c-c>',      '<esc>bi<<esc>ea><esc>F<vf>yPa')         --Emmet emulation
-- map('n', '<c-k>',      '<c-^>')                              --toggle close buffer

-- WINDOW NAVIGATION
map("n", "<c-h>", "<cmd>wincmd h<cr>")                          --move left window
map("n", "<c-n>", "<cmd>wincmd j<cr>")                          --move below window
map("n", "<c-p>", "<cmd>wincmd k<cr>")                          --move upper window
map("n", "<c-l>", "<cmd>wincmd l<cr>")                          --move right window

-- HARD TO MAP
vim.cmd([[
  inoremap <c-n> <cmd>:m .+1<cr>
  inoremap <c-p> <cmd>:m .-2<cr>
  vnoremap <c-n> :m '>+1<cr>gv=gv
  vnoremap <c-p> :m '<-2<cr>gv=gv

  nnoremap <leader>so :so %<cr>

  autocmd TermEnter term://*toggleterm#*
        \ tnoremap <silent><BS> <Cmd>exe v:count1 . "ToggleTerm"<cr>
  nnoremap <silent><BS> <Cmd>exe v:count1 . "ToggleTerm"<cr>
  inoremap <silent><BS> <Esc><Cmd>exe v:count1 . "ToggleTerm"<cr>

  snoremap <c-h> <BS>i

  nnoremap <leader>ss <CMD>LuaSnipUnlinkCurrent<CR>
]])

-- <EMMET>
-- vim.g.user_emmet_expandabbr_key = '<c-c>'
-- vim.g.user_emmet_leader_key='<C-)>' --I don't use all the emmet features.
