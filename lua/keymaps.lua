-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- <TELESCOPE>
keymap("n", "<leader>i", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>l", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>o", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<leader>p", "<cmd>Telescope oldfiles<cr>", opts)
keymap("n", "<leader>b", "<cmd>Telescope marks theme=ivy<cr>", opts)
keymap("n", "<leader>dl", "<cmd>Telescope grep_string<cr>", opts)
keymap("n", "<leader>dp", "<cmd>Telescope projects theme=dropdown <cr>", opts)
keymap("n", "<leader>di", "<cmd>Telescope git_status<cr>", opts)
keymap("n", "<leader>dd", "<cmd>Telescope colorscheme theme=dropdown winblend=0<cr>", opts)

-- <HARPOON>
keymap("n", "m<leader>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", opts)
keymap("n", "mm", "<cmd>lua require('harpoon.mark').add_file()<cr>", opts)
keymap("n", "mf", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", opts)
keymap("n", "me", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", opts)
keymap("n", "mw", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", opts)
keymap("n", "ma", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", opts)
keymap("n", "mq", "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", opts)
keymap("n", "mg", "<cmd>lua require('harpoon.term').gotoTerminal(1)<cr>", opts)
keymap("n", "mt", "<cmd>lua require('harpoon.term').gotoTerminal(2)<cr>", opts)

-- <TREE-CLIMBER>
keymap("n", "#", "<cmd>lua require('tree-climber').swap_prev()<cr>", opts)
keymap("n", "*", "<cmd>lua require('tree-climber').swap_next()<cr>", opts)

-- <NEORG GTD>
keymap("n", "<leader>h", "<cmd>Neorg gtd views<cr>", opts)
keymap("n", "<leader>vj", "<cmd>Neorg gtd capture<cr>", opts)
keymap("n", "<leader>ve", "<cmd>Neorg gtd edit<cr>", opts)

keymap("n", "mz", "<cmd>lua require('harpoon.term').sendCommand(1, 'ls -La<cr>')", opts)
keymap("n", "mx", "<cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<cr>", opts)
keymap("n", "mc", "<cmd>lua require('harpoon.term').sendCommand(1, 1)<cr>", opts)

-- <COLOR PICKER>
keymap("n", "<C-c>", "<cmd>PickColor<cr>", opts)
keymap("i", "<C-c>", "<cmd>PickColorInsert<cr>", opts)

-- <GIT SIGNS>
keymap("n", "gj", "<cmd>Gitsigns next_hunk<cr>^", opts)
keymap("n", "gk", "<cmd>Gitsigns prev_hunk<cr>^", opts)

-- <DIFF VIEW GIT>
keymap("n", "<leader>dj", "<cmd>DiffviewOpen<cr>", opts)
keymap("n", "<leader>df", "<cmd>DiffviewFileHistory %<cr>", opts)

-- <CYBU>
keymap("n", "<c-j>", "<plug>(CybuNext)", opts)
keymap("n", "<c-k>", "<plug>(CybuPrev)", opts)

-- <SESSION LENS>
keymap("n", "dp", "<cmd>SearchSession<cr>", opts)

-- <INLAY HINTS>
keymap("n", "<leader>dh", "<cmd>lua require('lsp-inlayhints').toggle()<cr>", opts)

-- <NVIM TREE>
keymap("n", "<leader>r", "<cmd>NvimTreeToggle <cr>", opts)

-- <MAXIMIZER>
keymap("n", "<leader>a", "<cmd>MaximizerToggle!<cr>", opts)

-- <CALENDAR>
keymap("n", "y", "<cmd>Calendar<CR>", opts)

-- <TRANSPARENCY>
keymap("n", "<leader><cr>", "<cmd>TransparentToggle<cr>", opts) -- gives info about current buffer

-- <BUFFERDELETE>
keymap("n", "<c-h>", "<cmd>Bdelete<CR>", opts) --buffer delete

-- NAVIGATION
keymap("n", "<c-r>", "<c-w>w", opts) --                 navigate next window
keymap("n", "<c-a>", "<c-w>W", opts) --             navigate previous window
keymap({ "n", "x" }, "<c-e>", "<c-y>", opts) --     page scrolls up one line
keymap({ "n", "x" }, "<c-f>", "<c-e>", opts) --   page scrolls down one line
keymap({ "n", "x" }, "<c-p>", "<c-b>", opts) --   page scrolls up fullscreen
keymap({ "n", "x" }, "<c-v>", "<c-f>", opts) -- page scrolls down fullscreen

-- RESIZE WINDOW
keymap("n", "ƒ", "<cmd>vertical resize +4<cr>", opts)
keymap("n", "∂", "<cmd>resize +4<cr>", opts)
keymap("n", "ß", "<cmd>resize -4<cr>", opts)
keymap("n", "å", "<cmd>vertical resize -4<cr>", opts)
keymap("n", "<leader><leader>", "<c-w>=", opts) -- center windows

-- INSERT MODE
keymap("i", "<c-f>", "<c-i>", opts) --                                         tab
keymap("i", "<c-k>", "<c-d>", opts) --                        move whole line left
keymap("i", "<c-l>", "<c-t>", opts) --                       move whole line right
keymap("i", "<c-v>", "<c-r>*", opts) --                 paste last registered yank
keymap("i", "<c-o>", "<esc>O", opts) --               go to upper line insert mode
keymap("i", "<c-i>", "<c-f>", opts) --    move line in the corresponding tab frame
keymap("i", "<c-e>", "<c-o>$", opts) -- goes end of the line and insert mode again

-- VISUAL MODE
keymap("n", "vv", "Vg_^", opts) --                   visual whole line
keymap("n", "V", "vg_", opts) --                   visual to the right
keymap({ "n", "x" }, "<c-l>", "<c-v>", opts) -- block visual selection
keymap("x", "<c-w>", "o", opts) --     o is used by treesitter-objects

-- SWITCH RECORD MACRO AND YANK
keymap("", "q", "y", opts)
keymap("n", "Q", "y$", opts)
keymap("n", "<tab>", "q", opts)

-- TABS
keymap("n", "<Leader>dt", "<cmd>tabnew %<cr>", opts) --  new tab
keymap("n", "<Leader>g", "gt", opts) --                 next tab
keymap("n", "<Leader>t", "gT", opts) --                 prev tab
keymap("n", "<Leader>u", "<cmd>tabclose<cr>", opts) -- close tab

-- Z MOVEMENTS
keymap({ "n", "v" }, "zl", "z6l", opts) --                   zoom left
keymap({ "n", "v" }, "zh", "z6h", opts) --                  zoom right
keymap({ "n", "v" }, "<Leader>j", "zz", opts) --           center text
keymap("n", "z.", ":<C-u>normal! zszH<cr>", opts) -- center horizontal

-- MOVE LINE/PARAGRAPH
keymap("x", "<c-j>", ":m '>+1<CR>gv=gv", opts)
keymap("x", "<c-k>", ":m '<-2<CR>gv=gv", opts)

-- SWITCH JUMPS
keymap("", "<c-o>", "<c-i>", opts)
keymap("", "<c-i>", "<c-o>", opts)

-- DEALING WITH WORD WRAP
keymap("", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap("", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- UTILS
keymap("n", "<c-q>", "<c-r>", opts) --                                    redo
keymap("n", "<leader>da", "<cmd>LuaSnipUnlinkCurrent<cr>", opts) --    luasnip
keymap("n", "<Leader>f", "<cmd>w<cr>", opts) --                      save file
keymap("n", "<leader>w", "<cmd>set hlsearch!<CR>", opts) --         highlights
keymap("n", "<c-s>", "<cmd>StartupTime<cr>", opts) --              startupTime
keymap("n", "<Leader>q", "<cmd>q<cr>", opts) --                   close window
keymap("n", "<leader>do", ":so %<cr>", opts) --           refresh lua settings
keymap("n", "<Leader>Q", "<cmd>q!<cr>", opts) --         close window and file
keymap("", "\\w", "`.") --                             go to last changed line
keymap("s", "<c-h>", "<BS>i", opts) --                luasnip delete selection
keymap("n", "<leader>c", "<c-g>", opts) --     gives info about current buffer
keymap("n", "d<leader>", "cc<esc>", opts) -- clear line without deleting break
keymap("n", "S", "mzJ`z", opts) --         cursor stay current position when J

-- D maps available:
-- q, r, y, u
-- s, <cr>
-- z, x, c, n, m
-- already used: p, o (mini_indent have effect on 'do'),

-- G maps available:
-- q, w, r, t, y, u, o (implementation remapeable)
-- <cr>
-- z, x

-- <C- > maps available
-- q (ugly redo), y, p (possibly unnecesary)
-- s (unnecesary), <cr>
-- z, x, v (possibly unnecesary), b, n, m?

-- <C- > insert mode maps available:
-- q, i, p, a, s, z, x, b, n, m
