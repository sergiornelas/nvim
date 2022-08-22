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
-- keymap("n", "<leader>dg", "<cmd>TodoTelescope theme=dropdown<cr>", opts)
-- keymap("n", "<leader>dh", "<cmd>Telescope heading theme=dropdown<cr>", opts) --neorg

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
keymap("n", "<leader>y", "<cmd>Calendar<CR>", opts)

-- <COLOR PICKER>
keymap("n", "<C-c>", "<cmd>PickColor<cr>", opts)
keymap("i", "<C-c>", "<cmd>PickColorInsert<cr>", opts)

-- <TRANSPARENCY>
keymap("n", "<leader><cr>", "<cmd>TransparentToggle<cr>", opts) -- gives info about current buffer

-- <BUFFERDELETE>
keymap("n", "<c-h>", "<cmd>Bdelete<CR>", opts) --buffer delete

-- NAVIGATION
keymap({ "n", "v" }, "<c-f>", "<c-e>", opts) -- page scrolls down one line
keymap({ "n", "v" }, "<c-e>", "<c-y>", opts) -- page scrolls up one line
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
keymap("v", "<c-w>", "o", opts) -- o is used by treesitter-objects
keymap("n", "<leader>w", "<cmd>set hlsearch!<CR>", opts) -- highlights
keymap("n", "<Leader>f", "<cmd>w<cr>", opts) -- save file
keymap("n", "<Leader>q", "<cmd>q<cr>", opts) -- close window
keymap("n", "<Leader>Q", "<cmd>q!<cr>", opts) -- close window and file
keymap({ "n", "v" }, "<Leader>j", "zz", opts) -- center text
keymap("n", "<Leader>g", "gt", opts) -- next tab
keymap("n", "<Leader>t", "gT", opts) -- prev tab
keymap("n", "<Leader>dt", "<cmd>tabnew %<cr>", opts) -- new tab
keymap("n", "<Leader>u", "<cmd>tabclose<cr>", opts) -- close current tab
keymap("n", "<c-s>", "<cmd>StartupTime<cr>", opts) -- StartupTime
keymap("n", "S", "mzJ`z", opts) -- cursor stay current position when J
keymap("n", "V", "vg_", opts) -- visual to the right
keymap("n", "vv", "Vg_^", opts) -- visual whole line
keymap({ "n", "v" }, "<c-l>", "<c-v>", opts) -- block visual selection
keymap({ "n", "v" }, "zl", "z6l", opts) -- zoom left
keymap({ "n", "v" }, "zh", "z6h", opts) -- zoom right
keymap("n", "d<leader>", "cc<esc>", opts) -- clear line without deleting break
keymap("n", "<leader>c", "<c-g>", opts) -- gives info about current buffer

-- COMMAND SUBSTITUTION
-- Decided to change vim default navigation keymaps because sometimes they are a pain in the ass.
-- Writing layer with semicolon (;) is managed by Karabiner.

--  WRITING            VIM EFFECT
-- -------------------------------
-- &?/+* #$%  \^      #?/{   () \^
-- QWERT˙UIO          QWER˙˙˙IO
-- ({;-[]=|~          ^;*}$=%&~
-- ASDFGHJKL          ASDFGHJKL
--  ! _`@})            | _`!~@
--  Z˙CVBNM            Z˙CVBNM

-- +-[] missing vim effect
-- ~^ are available for mapping (~ repeated in N)
-- \ is already mapped for move through diagnostics and go to head element

-- Q
keymap({ "n", "x" }, "&", "#", opts)
keymap("n", "d&", "d#", opts)
keymap("n", "q&", "y#", opts)
keymap("n", "c&", "c#", opts)
-- W, E no changes
-- R
keymap({ "n", "x" }, "+", "{", opts)
keymap("n", "d+", "d{", opts)
keymap("n", "q+", "y{", opts)
keymap("n", "c+", "c{", opts)
-- T is used by Tree-climber
-- Y not used
-- U is used by Tree-climber
-- I
keymap({ "n", "x" }, "$", "(", opts)
keymap("n", "d$", "d(", opts)
keymap("n", "q$", "y(", opts)
keymap("n", "c$", "c(", opts)
-- O
keymap({ "n", "x" }, "%", ")", opts)
keymap("n", "d%", "d)", opts)
keymap("n", "q%", "y)", opts)
keymap("n", "c%", "c)", opts)
-- A
keymap({ "n", "x" }, "(", "^", opts)
keymap("n", "d(", "d^", opts)
keymap("n", "q(", "y^", opts)
keymap("n", "c(", "c^", opts)
-- S
keymap({ "n", "x" }, "{", ";", opts)
keymap("n", "d{", "d;", opts)
keymap("n", "q{", "q;", opts)
keymap("n", "c{", "c;", opts)
-- D
keymap({ "n", "x" }, ";", "*", opts)
keymap("n", "d;", "d*", opts)
keymap("n", "q;", "y*", opts)
keymap("n", "c;", "c*", opts)
-- F
keymap({ "n", "x" }, "-", "}", opts)
keymap("n", "d-", "d}", opts)
keymap("n", "q-", "y}", opts)
keymap("n", "c-", "c}", opts)
-- G
keymap({ "n", "x" }, "[", "$", opts)
keymap("n", "d[", "d$", opts)
keymap("n", "q[", "y$", opts)
keymap("n", "c[", "c$", opts)
-- H
keymap({ "n", "x" }, "]", "==", opts)
-- J {n,x} already mapped by matchit
keymap("n", "d=", "d%", opts)
keymap("n", "q=", "y%", opts)
keymap("n", "c=", "c%", opts)
-- K
keymap({ "n", "v" }, "|", "&", opts)
-- L no changes
-- Z (q not working)
keymap({ "n", "x" }, "!", "|", opts)
keymap("n", "d!", "d|", opts)
keymap("n", "c!", "c|", opts)
-- X not used
-- C, V no changes
-- B
keymap("n", "@", "!", opts)
-- N
keymap({ "n", "x" }, "}", "~", opts)
-- M
keymap({ "n", "x" }, ")", "@", opts)

-- VIM MAPPING
vim.cmd([[
  " <LUASNIP>
  snoremap p p
  snoremap <c-h> <BS>i
  nnoremap <leader>da <CMD>LuaSnipUnlinkCurrent<CR>

  " Matchit (allows using % for <HTML>/<JSX> tags)
  nnoremap = <Plug>(MatchitNormalForward)
  vnoremap = <Plug>(MatchitVisualForward)

  " Macros in visual mode
  xnoremap ) :<C-u>call ExecuteMacroOverVisualRange()<CR>
  function! ExecuteMacroOverVisualRange()
  echo ")".getcmdline()
  execute ":'<,'>normal )".nr2char(getchar())
  endfunction

  " Move line/paragraph
  vnoremap <silent><c-j> :m '>+1<cr>gv=gv
  vnoremap <silent><c-k> :m '<-2<cr>gv=gv

  " Switch record macro and yank
  nnoremap q y
  vnoremap q y
  nnoremap Q y$
  nnoremap qq yy
  nnoremap <cr> q

  " Refresh lua settings
  nnoremap <leader>do :so %<cr>

  " Center horizontal
  nnoremap <silent> z. :<C-u>normal! zszH<CR>

  " Paste command mode
  cnoremap <c-v> <c-r>*
]])
