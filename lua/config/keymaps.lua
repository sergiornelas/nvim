vim.g.mapleader = " "
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- <LSP Saga>
keymap({ "n", "x" }, "gc", "<cmd>Lspsaga code_action<cr>")
keymap("n", "gr", "<cmd>Lspsaga rename<cr>")
keymap("n", "gR", "<cmd>Lspsaga rename ++project<cr>")
keymap("n", "gp", "<cmd>Lspsaga peek_definition<cr>")
keymap("n", "gl", "<cmd>Lspsaga show_line_diagnostics<cr>")
keymap("n", "gw", "<cmd>Lspsaga show_cursor_diagnostics<cr>")
keymap("n", "gB", "<cmd>Lspsaga show_buf_diagnostics<cr>")
keymap("n", "\\r", "<cmd>Lspsaga diagnostic_jump_prev<cr>")
keymap("n", "\\f", "<cmd>Lspsaga diagnostic_jump_next<cr>")
keymap("n", "\\t", function()
	require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)
keymap("n", "\\g", function()
	require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end)
keymap("n", "gz", "<cmd>Lspsaga outline<cr>")
keymap("n", "gh", "<cmd>Lspsaga hover_doc<cr>")
keymap("n", "gH", "<cmd>Lspsaga hover_doc ++keep<cr>")

-- <Typerscript>
keymap("n", "<leader>Ti", "<cmd>TypescriptAddMissingImports<cr>", opts)
keymap("n", "<leader>To", "<cmd>TypescriptOrganizeImports<cr>", opts)
keymap("n", "<leader>Tu", "<cmd>TypescriptRemoveUnused<cr>", opts)
keymap("n", "<leader>Tf", "<cmd>TypescriptFixAll<cr>", opts)
keymap("n", "<leader>Tr", "<cmd>TypescriptRenameFile<cr>", opts)
keymap("n", "<leader>Td", "<cmd>TypescriptGoToSourceDefinition<cr>", opts) -- Typescript 4.7+

-- <Grapple>
keymap("", "mv", "<cmd>lua require('grapple').popup_tags()<cr>", opts)
keymap("", "mm", "<cmd>lua require('grapple').toggle()<cr>", opts)
keymap("", "mf", "<cmd>lua require('grapple').select({key=1})<cr>", opts)
keymap("", "me", "<cmd>lua require('grapple').select({key=2})<cr>", opts)
keymap("", "mw", "<cmd>lua require('grapple').select({key=3})<cr>", opts)
keymap("", "ma", "<cmd>lua require('grapple').select({key=4})<cr>", opts)
keymap("", "mr", "<cmd>lua require('grapple').select({key=5})<cr>", opts)
keymap("", "mt", "<cmd>lua require('grapple').select({key=6})<cr>", opts)
keymap("", "mq", ":lua require('grapple').tag({ key = '", { noremap = true })
keymap("n", "<c-j>", "<cmd>lua require('grapple').cycle_backward()<cr>", opts)
keymap("n", "<c-k>", "<cmd>lua require('grapple').cycle_forward()<cr>", opts)
-- keymap("", "<leader>vh", "<cmd>lua require('grapple').popup_tags('global')<cr>", opts)

-- <Telescope>
keymap("", "<leader>u", "<cmd>Telescope oldfiles<cr>", opts)
keymap("", "<leader>i", "<cmd>Telescope find_files<cr>", opts)
keymap("", "<leader>o", "<cmd>Telescope buffers<cr>", opts)
keymap("", "<leader>l", "<cmd>Telescope live_grep<cr>", opts)
keymap("", "<leader>k", "<cmd>Telescope git_status<cr>", opts)
keymap("", "<leader>s", "<cmd>Telescope grep_string<cr>", opts)
keymap("", "<leader>M", "<cmd>Telescope marks theme=ivy<cr>", opts)
keymap("n", "<leader>c", "<cmd>Telescope colorscheme theme=dropdown winblend=0<cr>", opts)

-- <Neorg>
keymap("", ",f", "<c-w>s<cmd>Neorg workspace todo<cr>", opts)
keymap("", ",W", ":Neorg workspace ", { noremap = true })
keymap("", ",i", "<cmd>Neorg index<cr>", opts)
keymap("", ",q", "<cmd>Neorg return<cr>", opts)
keymap("", ",z", "<cmd>Neorg toc<cr>", opts)
keymap("", ",c", "<cmd>Neorg toggle-concealer<cr>", opts)
keymap("", "<leader><leader>", "<cmd>bp<cr><cmd>bn<cr>", opts)

-- <Leap>
keymap({ "n", "x" }, "s", function()
	require("leap").leap({ target_windows = { vim.fn.win_getid() } })
end)

-- <Diff view git>
keymap("", "<leader>d", "<cmd>DiffviewOpen<cr>", opts)
keymap("", "<leader>jf", "<cmd>DiffviewFileHistory %<cr>", opts)
keymap("", "<leader>jg", "<cmd>DiffviewFileHistory<cr>", opts)

-- <Windows>
keymap("n", "<c-w><c-e>", "<cmd>WindowsMaximize<cr>", opts)
keymap("n", "<c-w><c-q>", "<cmd>WindowsToggleAutowidth<cr>", opts)

-- <Illuminate>
keymap("", "}", "<cmd>lua require('illuminate').goto_next_reference(wrap)<cr>", opts)
keymap("", "*", "<cmd>lua require('illuminate').goto_prev_reference(wrap)<cr>", opts)

-- <Swap-split>
keymap("", "<c-w><c-u>", "<cmd>SwapSplit<cr>", opts)
keymap("", "<c-w>u", "<cmd>SwapSplit<cr>", opts)

-- <Color picker>
keymap("n", "<c-c>", "<cmd>CccPick<cr>", opts)

-- <Lazy>
keymap("n", "<leader>v", "<cmd>Lazy<cr>", opts)

-- <Px-Rem>
keymap("", "<leader>P", "<cmd>Px!<cr>", opts)
keymap("", "<leader>R", "<cmd>Rem!<cr>", opts)

-- <Session lens>
keymap({ "n", "x" }, "mg", "<cmd>SearchSession<cr>", opts)

-- <Glance>
keymap("n", "go", "<cmd>Glance references<cr>")

-- <Nvim tree>
keymap("", "<leader>a", "<cmd>NvimTreeToggle<cr>", opts)

-- <Inlay hints>
keymap("", "<leader>r", "<cmd>lua require('lsp-inlayhints').toggle()<cr>", opts)

-- <Bufferdelete>
keymap("", "<c-h>", "<cmd>Bdelete<cr>", opts) --buffer delete

-- <Mini trailspace>
keymap("", "<leader>b", "<cmd>lua require('mini.trailspace').trim()<cr>", opts)

-- <Zippy>
keymap("", "<leader>z", "<cmd>lua require('zippy').insert_print()<cr>", opts)

-- <Cellular-automaton>
keymap("", "]", "<cmd>CellularAutomaton make_it_rain<cr>", opts)

-- <TreeSJ>
keymap("", "<leader>p", "<cmd>TSJToggle<cr>", opts)

-- Open links under cursor in browser
if vim.fn.has("macunix") == 1 then
	keymap("n", "gx", "<cmd>silent execute '!open ' . shellescape('<cWORD>')<cr>", opts)
else
	keymap("n", "gx", "<cmd>silent execute '!xdg-open ' . shellescape('<cWORD>')<cr>", opts)
end

-- Navigation
keymap("", "<leader>q", "<cmd>q<cr>", opts) --             close window
keymap("", "<leader>Q", "<cmd>q!<cr>", opts) -- close window and buffer
keymap("", "<c-v>", "<c-^>", opts) --              toggle recent window
keymap("", "<c-r>", "<c-w>w", opts) --             navigate next window
keymap("n", "<c-u>", "<c-u>zz", opts) --         scrolls up half buffer
keymap("n", "<c-d>", "<c-d>zz", opts) --       scrolls down half buffer
keymap("", "<c-a>", "<c-w>W", opts) --         navigate previous window
keymap("", "<c-e>", "<c-y>", opts) --          page scrolls up one line
keymap("", "<c-f>", "<c-e>", opts) --        page scrolls down one line
keymap("", "<c-p>", "<c-b>", opts) --        page scrolls up fullscreen
keymap("", "<c-b>", "<c-f>", opts) --      page scrolls down fullscreen

-- Resize window
keymap("", "ƒ", "<cmd>vertical resize +4<cr>", opts)
keymap("", "∂", "<cmd>resize +4<cr>", opts)
keymap("", "ß", "<cmd>resize -4<cr>", opts)
keymap("", "å", "<cmd>vertical resize -4<cr>", opts)

-- Insert mode
keymap("i", "<c-f>", "<c-i>", opts) --                                         tab
keymap("i", "<c-k>", "<c-d>", opts) --                        move whole line left
keymap("i", "<c-l>", "<c-t>", opts) --                       move whole line right
keymap("i", "<c-v>", "<c-r>*", opts) --                 paste last registered yank
keymap("i", "<c-o>", "<esc>O", opts) --               go to upper line insert mode
keymap("i", "<c-i>", "<c-f>", opts) --    move line in the corresponding tab frame
keymap("i", "<c-e>", "<c-o>$", opts) -- goes end of the line and insert mode again

-- Tabs
keymap("", "<leader>e", "gt", opts) --                 next tab
keymap("", "<leader>w", "gT", opts) --                 prev tab
keymap("", "<leader>t", "<cmd>tabclose<cr>", opts) -- close tab

-- Visual mode
keymap("", "<c-l>", "<c-v>", opts) --       block visual selection
keymap("x", "<leader>p", '"_dP', opts) -- paste and don't register

-- Switch record macro and yank
keymap("", "q", "y", opts)
keymap({ "n", "x" }, "Q", "y$", opts)

-- Lua snip conflicts
keymap("s", "<c-h>", "<BS>i", opts)
keymap("s", "q", "q", opts)
keymap("s", "#", "#", opts)
keymap("s", "*", "*", opts)

-- Z movements
keymap({ "n", "x" }, "zl", "z25l", opts) --                           zoom left
keymap({ "n", "x" }, "zh", "z25h", opts) --                          zoom right
keymap({ "n", "x" }, "gj", "zz", opts) --                           center text
keymap({ "n", "x" }, "z.", ":<c-u>normal! zszH<cr>", opts) -- center horizontal

-- Don't yank on delete char
keymap({ "n", "v" }, "x", '"_x', opts)
keymap({ "n", "v" }, "X", '"_X', opts)

-- Move line/paragraph
keymap("x", "<c-j>", ":move '>+1<cr>gv-gv", opts)
keymap("x", "<c-k>", ":move '<-2<cr>gv-gv", opts)

-- Switch jumps
keymap("n", "<c-o>", "<c-i>", opts)
keymap("n", "<c-i>", "<c-o>", opts)

-- Switch middle cursor
keymap("n", "gm", "gM", opts)
keymap("n", "gM", "gm", opts)

-- Utils
keymap("n", "U", "<c-r>", opts) --                                         redo
keymap("", "<leader>f", "<cmd>w<cr>", opts) --                        save file
keymap("", "<leader>h", "<cmd>set hlsearch!<cr>", opts) --           highlights
keymap("n", "<c-q>", "<cmd>qa<cr>", opts) --                        exit neovim
keymap({ "n", "x" }, "g<c-x>", "g<c-a>") --                     increase column
keymap({ "n", "x" }, "g<c-z>", "g<c-x>") --                     decrease column
keymap("", "<leader>W", "<cmd>set wrap!<cr>", opts) --          toggle set wrap
keymap("", "<leader>S", "<cmd>set spell!<cr>", opts) --        toggle set spell
keymap("", "<leader>n", "<cmd>set nu!<cr>", opts) --          toggle set number
keymap("", "\\<leader>", "`.") --                       go to last changed line
keymap("n", "d<leader>", "cc<esc>", opts) --  clear line without deleting break
keymap({ "n", "x" }, "y", "mzJ`z", opts) -- cursor stay current position when J

-- Shift char available:
-- Y
-- Z

-- <tab> and <esc> are free

-- D maps available:
-- q, r, y
-- <cr>
-- z, x, c

-- C maps available:
-- r, y, u, p
-- d, g, <cr>
-- z, m

-- G maps available:
-- y, i (goes insert where stopped)
-- k
-- <cr>

-- <leader> maps available:
-- y
-- <cr>
-- x, c, m
-- <esc>
-- caps chars (G, C...)
-- combinations with: j
-- Reverse available: z, c

-- <C-> maps available:
-- y, p
-- <cr>
-- b, n

-- <C-W>_ maps available:
-- t (first window), i (definition), o (delete all), f (file), n (new empty buffer)
-- w, y, p
-- a, d, g, h, k, l
-- z, x, c, b, m

-- <C-> insert mode maps available:
-- q, p
-- s
-- z, b, n, m

-- \ maps available
-- y, u, i, o, p
-- h, k, l
-- z, x, b, n

-- q maps available
-- yank + key

-- Used but mappeable
-- <leader>v ~ lazy
-- <leader>n ~ set number
-- <leader>r ~ inlay
-- <leader>p ~ treesj
-- <leader><leader> ~ previous and next buffer (for norg)
