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
keymap(
	"n",
	"<leader>dd",
	":lua require('telescope.builtin').colorscheme(require('telescope.themes').get_dropdown{ previewer = false, winblend=0, layout_config={width=30}})<cr>",
	opts
)

-- <SESSION LENS>
keymap("n", "dp", "<cmd>SearchSession<cr>", opts)

-- <INLAY HINTS>
keymap("n", "<leader>dh", "<cmd>lua require('lsp-inlayhints').toggle()<cr>", opts)

-- <NVIM TREE>
keymap("n", "<leader>r", "<cmd>NvimTreeToggle <cr>", opts)

-- <GIT SIGNS>
keymap("n", "gj", "<cmd>Gitsigns next_hunk<cr>^", opts)
keymap("n", "gk", "<cmd>Gitsigns prev_hunk<cr>^", opts)

-- <NEORG GTD>
keymap("n", "<leader>h", "<cmd>Neorg gtd views<cr>", opts)
keymap("n", "<leader>vj", "<cmd>Neorg gtd capture<cr>", opts)
keymap("n", "<leader>ve", "<cmd>Neorg gtd edit<cr>", opts)

-- <MAXIMIZER>
keymap("n", "<leader>a", "<cmd>MaximizerToggle!<cr>", opts)

-- <DIFF VIEW GIT>
keymap("n", "<leader>dj", "<cmd>DiffviewOpen<cr>", opts)
keymap("n", "<leader>df", "<cmd>DiffviewFileHistory %<cr>", opts)

-- <CYBU>
keymap("n", "<c-j>", "<plug>(CybuLastusedNext)", opts)
keymap("n", "<c-k>", "<plug>(CybuLastusedPrev)", opts)

-- <TREE-CLIMBER>
keymap({ "n", "v", "o" }, "J", "^<cmd>lua require('tree-climber').goto_next()<cr>", opts)
keymap({ "n", "v", "o" }, "K", "^<cmd>lua require('tree-climber').goto_prev()<cr>", opts)
keymap("n", "#", "<cmd>lua require('tree-climber').swap_prev()<cr>", opts)
keymap("n", "*", "<cmd>lua require('tree-climber').swap_next()<cr>", opts)

-- <HARPOON>
keymap(
	"n",
	"<leader>e",
	"<cmd>lua require('telescope').extensions.harpoon.marks({layout_strategy='vertical', prompt_title='~< Hookshot >~', layout_config={height=36, preview_height=20}})<cr>",
	opts
)
keymap("n", "mf", "<cmd>lua require('harpoon.mark').add_file()<cr>", opts)

-- <CALENDAR>
keymap("n", "y", "<cmd>Calendar<CR>", opts)

-- <COLOR PICKER>
keymap("n", "<C-c>", "<cmd>PickColor<cr>", opts)
keymap("i", "<C-c>", "<cmd>PickColorInsert<cr>", opts)

-- <TRANSPARENCY>
keymap("n", "<leader><cr>", "<cmd>TransparentToggle<cr>", opts) -- gives info about current buffer

-- <BUFFERDELETE>
keymap("n", "<c-h>", "<cmd>Bdelete<CR>", opts) --buffer delete

-- NAVIGATION
keymap({ "n", "x" }, "<c-f>", "<c-e>", opts) -- page scrolls down one line
keymap({ "n", "x" }, "<c-e>", "<c-y>", opts) --   page scrolls up one line
keymap({ "n", "x" }, "<c-v>", "<c-f>", opts) --                 fullscreen
keymap({ "n", "x" }, "<c-p>", "<c-b>", opts) --                 fullscreen
keymap("n", "<c-r>", "<c-w>w", opts) --           navigate through windows
keymap("n", "<c-a>", "<c-w>W", opts) --           navigate through windows

-- RESIZE WINDOW
keymap("n", "å", "<cmd>vertical resize +4<cr>", opts)
keymap("n", "∂", "<cmd>resize +4<cr>", opts)
keymap("n", "ß", "<cmd>resize -4<cr>", opts)
keymap("n", "ƒ", "<cmd>vertical resize -4<cr>", opts)
keymap("n", "<leader><leader>", "<c-w>=", opts) -- center windows

-- DEALING WITH WORD WRAP
keymap("", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap("", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- INSERT MODE
keymap("i", "<c-f>", "<c-i>", opts) --                                         tab
keymap("i", "<c-e>", "<c-o>$", opts) -- goes end of the line and insert mode again
keymap("i", "<c-k>", "<c-d>", opts) --                        move whole line left
keymap("i", "<c-l>", "<c-t>", opts) --                       move whole line right
keymap("i", "<c-o>", "<esc>O", opts) --               go to upper line insert mode
keymap("i", "<c-v>", "<c-r>*", opts) --                 paste last registered yank
keymap("i", "<c-i>", "<c-f>", opts) --     move line in the correspondng tab frame

-- SWITCH RECORD MACRO AND YANK
keymap("", "q", "y", opts)
keymap("n", "Q", "y$", opts)
keymap("n", "dm", "q", opts)
keymap("n", "!!", "@@", opts)

-- MOVE LINE/PARAGRAPH
keymap("x", "<c-j>", ":m '>+1<CR>gv=gv", opts)
keymap("x", "<c-k>", ":m '<-2<CR>gv=gv", opts)

-- UTILS
keymap("n", "<c-q>", "<c-r>", opts) --                                    redo
keymap("v", "<c-w>", "o", opts) --             o is used by treesitter-objects
keymap("n", "<leader>w", "<cmd>set hlsearch!<CR>", opts) --         highlights
keymap("n", "<Leader>f", "<cmd>w<cr>", opts) --                      save file
keymap("n", "<Leader>q", "<cmd>q<cr>", opts) --                   close window
keymap("n", "<Leader>Q", "<cmd>q!<cr>", opts) --         close window and file
keymap({ "n", "v" }, "<Leader>j", "zz", opts) --                   center text
keymap("n", "<Leader>g", "gt", opts) --                               next tab
keymap("n", "<Leader>t", "gT", opts) --                               prev tab
keymap("n", "<Leader>dt", "<cmd>tabnew %<cr>", opts) --                new tab
keymap("n", "<Leader>u", "<cmd>tabclose<cr>", opts) --       close current tab
keymap("n", "<c-s>", "<cmd>StartupTime<cr>", opts) --              startupTime
keymap("n", "S", "mzJ`z", opts) --         cursor stay current position when J
keymap("n", "V", "vg_", opts) --                           visual to the right
keymap("n", "vv", "Vg_^", opts) --                           visual whole line
keymap({ "n", "v" }, "<c-l>", "<c-v>", opts) --         block visual selection
keymap({ "n", "v" }, "zl", "z6l", opts) --                           zoom left
keymap({ "n", "v" }, "zh", "z6h", opts) --                          zoom right
keymap("n", "d<leader>", "cc<esc>", opts) -- clear line without deleting break
keymap("n", "<leader>c", "<c-g>", opts) --     gives info about current buffer
keymap("s", "<c-h>", "<BS>i", opts) --                luasnip delete selection
keymap("n", "<leader>do", ":so %<cr>", opts) --           refresh lua settings
keymap("n", "z.", ":<C-u>normal! zszH<cr>", opts) --         center horizontal

-- D maps
-- available: ds, dq, dr, du, dm, dp, dc, do
-- already used: dp, dm, do (mini_indent have effect on 'do'),
-- <c-leader> is mapeable
