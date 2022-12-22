vim.g.mapleader = " "
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- <LSP Saga>
keymap("n", "gk", "<cmd>Lspsaga lsp_finder<cr>", { silent = true })
keymap({ "n", "x" }, "gc", "<cmd>Lspsaga code_action<cr>", { silent = true })
keymap("n", "gr", "<cmd>Lspsaga rename<cr>", { silent = true })
keymap("n", "gp", "<cmd>Lspsaga peek_definition<cr>", { silent = true })
keymap("n", "gl", "<cmd>Lspsaga show_line_diagnostics<cr>", { silent = true })
keymap("n", "gw", "<cmd>Lspsaga show_cursor_diagnostics<cr>", { silent = true })
keymap("n", "\\r", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { silent = true })
keymap("n", "\\f", "<cmd>Lspsaga diagnostic_jump_next<cr>", { silent = true })
keymap("n", "\\t", function()
	require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
keymap("n", "\\g", function()
	require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
keymap("n", "gz", "<cmd>LSoutlineToggle<cr>", { silent = true })
keymap("n", "gh", "<cmd>Lspsaga hover_doc<cr>", { silent = true })

-- <Typerscript>
keymap("n", "<leader>vI", "<cmd>TypescriptAddMissingImports<cr>", opts)
keymap("n", "<leader>vO", "<cmd>TypescriptOrganizeImports<cr>", opts)
keymap("n", "<leader>vU", "<cmd>TypescriptRemoveUnused<cr>", opts)
keymap("n", "<leader>vF", "<cmd>TypescriptFixAll<cr>", opts)
keymap("n", "<leader>vR", "<cmd>TypescriptRenameFile<cr>", opts)
keymap("n", "<leader>vd", "<cmd>TypescriptGoToSourceDefinition<cr>", opts) -- Typescript 4.7+

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
keymap("", "<leader>b", "<cmd>Telescope marks theme=ivy<cr>", opts)
keymap("n", "<leader>p", "<cmd>Telescope colorscheme theme=dropdown winblend=0<cr>", opts)

-- <Diff view git>
keymap("", "<leader>d", "<cmd>DiffviewOpen<cr>", opts)
keymap("", "<leader>jf", "<cmd>DiffviewFileHistory %<cr>", opts)
keymap("", "<leader>jg", "<cmd>DiffviewFileHistory<cr>", opts)

-- <Windows>
keymap("n", "v<leader>", "<cmd>WindowsMaximize<cr>", opts)
keymap("n", "<c-w>z", "<cmd>WindowsToggleAutowidth<cr>", opts)

-- <Illuminate>
keymap("", "`", "<cmd>lua require('illuminate').goto_next_reference(wrap)<cr>", opts)
keymap("", "*", "<cmd>lua require('illuminate').goto_prev_reference(wrap)<cr>", opts)

-- <Color picker>
keymap("n", "<c-c>", "<cmd>CccPick<cr>", opts)
keymap("i", "<c-c>", "<Plug>(ccc-insert)<cr>", opts)

-- <Px-Rem>
keymap("", "<leader>vp", "<cmd>Px!<cr>", opts)
keymap("", "<leader>vr", "<cmd>Rem!<cr>", opts)

-- <Session lens>
keymap({ "n", "x" }, "mg", "<cmd>SearchSession<cr>", opts)

-- <Nvim tree>
keymap("", "<leader>g", "<cmd>NvimTreeToggle <cr>", opts)

-- <Inlay hints>
keymap("", "<leader>h", "<cmd>lua require('lsp-inlayhints').toggle()<cr>", opts)

-- <Transparency>
keymap("", "<leader><cr>", "<cmd>TransparentToggle<cr>", opts) -- gives info about current buffer

-- <Bufferdelete>
keymap("", "<c-h>", "<cmd>Bdelete<cr>", opts) --buffer delete

-- <Mini trailspace>
keymap("", "<leader>va", "<cmd>lua require('mini.trailspace').trim()<cr>", opts)

-- <Zippy>
keymap("", "<leader>vz", "<cmd>lua require('zippy').insert_print()<cr>", opts)

-- <Swap-split>
keymap("", "<leader>vs", "<cmd>SwapSplit<cr>", opts)

-- <Fsread>
keymap("", "<leader>vf", "<cmd>FSToggle<cr>", opts)

-- <Cellular-automaton>
keymap("", "<c-s>", "<cmd>CellularAutomaton make_it_rain<cr>", opts)

-- <Twoslash-queries>
keymap("", "<leader>vq", "<cmd>InspectTwoslashQueries<cr>", opts)

-- <TreeSJ>
keymap("", "<leader>vj", "<cmd>TSJToggle<cr>", opts)

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
keymap("", "<c-a>", "<c-w>W", opts) --         navigate previous window
keymap("n", "<c-d>", "<c-d>zz", opts) --       scrolls down half buffer
keymap("n", "<c-u>", "<c-u>zz", opts) --       scrolls down half buffer
keymap("", "<c-e>", "<c-y>", opts) --          page scrolls up one line
keymap("", "<c-f>", "<c-e>", opts) --        page scrolls down one line
keymap("", "<c-p>", "<c-b>", opts) --        page scrolls up fullscreen
keymap("", "<c-b>", "<c-f>", opts) --      page scrolls down fullscreen

-- Resize window
keymap("", "ƒ", "<cmd>vertical resize +4<cr>", opts)
keymap("", "∂", "<cmd>resize +4<cr>", opts)
keymap("", "ß", "<cmd>resize -4<cr>", opts)
keymap("", "å", "<cmd>vertical resize -4<cr>", opts)
keymap("", "<leader><leader>", "<c-w>=", opts)

-- Insert mode
keymap("i", "<c-f>", "<c-i>", opts) --                                         tab
keymap("i", "<c-k>", "<c-d>", opts) --                        move whole line left
keymap("i", "<c-l>", "<c-t>", opts) --                       move whole line right
keymap("i", "<c-v>", "<c-r>*", opts) --                 paste last registered yank
keymap("i", "<c-o>", "<esc>O", opts) --               go to upper line insert mode
keymap("i", "<c-i>", "<c-f>", opts) --    move line in the corresponding tab frame
keymap("i", "<c-e>", "<c-o>$", opts) -- goes end of the line and insert mode again

-- Visual mode
keymap("n", "vv", "Vg_^", opts) --                                     visual whole line
keymap("", "<c-l>", "<c-v>", opts) --                             block visual selection
keymap("x", "<leader>p", '"_dP', opts) --                       paste and don't register
keymap("x", "<c-w>", "o", opts) --                       o is used by treesitter-objects
keymap("x", "!", '":norm !" . getcharstr() . "<cr>"', { expr = true }) -- multiple macro

-- Tabs
keymap("", "<leader>n", "<c-w>T", opts) --              new tab
keymap("", "<leader>e", "gt", opts) --                 next tab
keymap("", "<leader>r", "gT", opts) --                 prev tab
keymap("", "<leader>t", "<cmd>tabclose<cr>", opts) -- close tab

-- Switch record macro and yank
keymap("", "q", "y", opts)
keymap("n", "<tab>", "q", opts)
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
keymap("n", "<c-q>", "<c-r>", opts) --                                     redo
keymap("", "<leader>f", "<cmd>w<cr>", opts) --                        save file
keymap("", "<leader>a", "<cmd>set hlsearch!<cr>", opts) --           highlights
-- keymap("", "<c-s>", "<cmd>PackerSync<cr>", opts) --           update plugins
keymap({ "n", "x" }, "g<c-x>", "g<c-a>") --                     increase column
keymap({ "n", "x" }, "g<c-z>", "g<c-x>") --                     decrease column
keymap("", "<leader>W", "<cmd>set wrap!<cr>", opts) --          toggle set wrap
keymap("", "<leader>S", "<cmd>set spell!<cr>", opts) --        toggle set spell
keymap("", "<leader>z", "<cmd>set nu!<cr>", opts) --          toggle set number
keymap("", "\\<leader>", "`.") --                       go to last changed line
keymap("n", "d<leader>", "cc<esc>", opts) --  clear line without deleting break
keymap({ "n", "x" }, "y", "mzJ`z", opts) -- cursor stay current position when J

-- Shift char available:
-- Y

-- <esc> is free

-- D maps available:
-- r, y
-- <cr>
-- x, c

-- C maps available:
-- q, r, y, u, p
-- d, g, <cr>
-- z, m

-- G maps available:
-- y
-- <cr>

-- <leader> maps available:
-- y
-- x, c, m
-- <esc>
-- caps chars
-- combinations with: j, v
-- Reverse available: z, c

-- <C-> maps available:
-- y
-- s <cr>
-- n

-- <C-> insert mode maps available:
-- q, p
-- s
-- z, b, n, m

-- \ maps available
-- y, u, i, o, p
-- h, k, l
-- z, x, b, n

-- === List of not really used plugins:
-- treesj (align arrays objects)                      leader vj
-- zippy (automatic comments)                         leader vz
-- twoslash queries (typescript detailed info /?)     leader vq
-- fsread (better reading)                            leader vf
-- dotenv (refresh dotenv?)
