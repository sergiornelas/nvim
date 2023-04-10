vim.g.mapleader = " "
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- <LSP Saga>
-- keymap({ "n", "x" }, "gc", "<cmd>Lspsaga code_action<cr>")
-- keymap("n", "gr", "<cmd>Lspsaga rename<cr>")
-- keymap("n", "gl", "<cmd>Lspsaga show_line_diagnostics<cr>")
-- keymap("n", "gw", "<cmd>Lspsaga show_cursor_diagnostics<cr>")
-- keymap("n", "gB", "<cmd>Lspsaga show_buf_diagnostics<cr>")
-- keymap("n", "\\r", "<cmd>Lspsaga diagnostic_jump_prev<cr>")
-- keymap("n", "\\f", "<cmd>Lspsaga diagnostic_jump_next<cr>")
-- keymap("n", "\\t", function()
-- 	require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
-- end)
-- keymap("n", "\\g", function()
-- 	require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
-- end)
-- keymap("n", "gh", "<cmd>Lspsaga hover_doc<cr>")
keymap("n", "gH", "<cmd>Lspsaga hover_doc ++keep<cr>")
keymap("n", "gR", "<cmd>Lspsaga rename ++project<cr>")
keymap("n", "gp", "<cmd>Lspsaga peek_definition<cr>")
keymap("n", "gO", "<cmd>Lspsaga outline<cr>")

-- <Typerscript>
keymap("n", "<leader>Ti", "<cmd>TypescriptAddMissingImports<cr>", opts)
keymap("n", "<leader>To", "<cmd>TypescriptOrganizeImports<cr>", opts)
keymap("n", "<leader>Tu", "<cmd>TypescriptRemoveUnused<cr>", opts)
keymap("n", "<leader>Tf", "<cmd>TypescriptFixAll<cr>", opts)
keymap("n", "<leader>Tr", "<cmd>TypescriptRenameFile<cr>", opts)
keymap("n", "<leader>Td", "<cmd>TypescriptGoToSourceDefinition<cr>", opts) -- Typescript 4.7+

-- <Grapple>
keymap("n", "m<leader>", "<cmd>GrappleToggle<cr>", opts)
keymap("n", "mt", ":GrappleTag key=", { noremap = true })
keymap("n", "mT", ":GrappleTag scope=global key=", { noremap = true })
keymap("n", "mv", "<cmd>GrapplePopup tags<cr>", opts)
keymap("n", "mG", "<cmd>lua require('grapple').popup_tags('global')<cr>", opts)
keymap("n", "mf", "<cmd>GrappleSelect key=1<cr>", opts)
keymap("n", "me", "<cmd>GrappleSelect key=2<cr>", opts)
keymap("n", "mw", "<cmd>GrappleSelect key=3<cr>", opts)
keymap("n", "ma", "<cmd>GrappleSelect key=4<cr>", opts)
keymap("n", "ms", "<cmd>GrappleSelect key=5<cr>", opts)
keymap("n", "md", "<cmd>GrappleSelect key=6<cr>", opts)
keymap("n", "J", "<cmd>GrappleCycle backward<cr>", opts)
keymap("n", "K", "<cmd>GrappleCycle forward<cr>", opts)

-- <Telescope>
keymap("", "<leader>u", "<cmd>Telescope oldfiles<cr>", opts)
keymap("", "<leader>i", "<cmd>Telescope find_files<cr>", opts)
keymap("", "<leader>o", "<cmd>Telescope buffers<cr>", opts)
keymap("", "<leader>l", "<cmd>Telescope live_grep<cr>", opts)
keymap("", "<leader>k", "<cmd>Telescope git_status<cr>", opts)
keymap("", "<leader>s", "<cmd>Telescope grep_string<cr>", opts)
keymap("", "<leader>m", "<cmd>Telescope marks theme=ivy<cr>", opts)
keymap("", "<leader>H", "<cmd>Telescope help_tags theme=ivy<cr>", opts)
keymap("", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find theme=ivy<cr>", opts)
keymap("i", "<c-r>", "<cmd>Telescope registers theme=cursor layout_config={height=0.3}<cr>", opts)

-- <LSP-Signature>
keymap({ "n", "i" }, "<c-s>", function()
	require("lsp_signature").toggle_float_win()
end, opts)

-- <Neorg>
keymap("", "mg", "<c-w>s<cmd>Neorg workspace todo<cr>", opts)
keymap("", "mq", "<cmd>Neorg return<cr>", opts)
keymap("", ",W", ":Neorg workspace ", { noremap = true })
keymap("", ",i", "<cmd>Neorg index<cr>", opts)
keymap("", ",t", "<cmd>Neorg toc<cr>", opts)
keymap("", ",c", "<cmd>Neorg toggle-concealer<cr>", opts)

-- <Diff view git>
keymap("", "<leader>d", "<cmd>DiffviewOpen<cr> | <cmd>TabooRename Diffview  <cr> ", opts)
keymap("", "<leader>jf", "<cmd>DiffviewFileHistory %<cr> | <cmd>TabooRename FileHistory  <cr>", opts)
keymap("", "<leader>jp", "<cmd>DiffviewFileHistory<cr> | <cmd>TabooRename ProjectHistory  <cr>", opts)

-- <Move>
keymap("v", "<c-j>", ":MoveBlock(1)<cr>", opts)
keymap("v", "<c-k>", ":MoveBlock(-1)<cr>", opts)
keymap("v", "<c-c>", ":MoveHBlock(-1)<cr>", opts)
keymap("v", "<c-v>", ":MoveHBlock(1)<cr>", opts)

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
keymap("n", "<leader>F", "<cmd>Lazy<cr>", opts)

-- <Glance>
keymap("n", "go", "<cmd>Glance references<cr>")

-- <Navbuddy>
keymap("n", "<leader>n", "<cmd>Navbuddy<cr>")

-- <Inlay hints>
keymap("", "<leader>v", "<cmd>lua require('lsp-inlayhints').toggle()<cr>", opts)

-- <Code runner>
keymap("n", "<leader>r", "<cmd>RunCode<cr>", opts)

-- <Taboo>
keymap("n", "<leader>R", ":TabooRename ", { noremap = true })
keymap("n", "<leader>C", "<cmd>TabooReset<cr>", opts)

-- <Bufferdelete>
keymap("n", "<c-h>", "<cmd>Bdelete<cr>", opts) --buffer delete

-- <Mini trailspace>
keymap("", "<leader>b", "<cmd>lua require('mini.trailspace').trim()<cr>", opts)

-- <Cellular-automaton>
keymap("", "]", "<cmd>CellularAutomaton make_it_rain<cr>", opts)

-- <TreeSJ>
keymap("", "<leader>p", "<cmd>TSJToggle<cr>", opts)

-- <Gitsigns> and next/prev diff line
vim.api.nvim_exec(
	[[
    noremap <expr> <c-g> &diff ? ']c' : "<cmd>Gitsigns next_hunk<cr>"
    noremap <expr> <c-t> &diff ? '[c' : "<cmd>Gitsigns prev_hunk<cr>"
  ]],
	false
)

-- <Codi-Runner> and <Neorg> refresh
vim.api.nvim_exec(
	[[
  nnoremap <leader>G :tabnew ~/scratchFiles/scratch.ts<cr>:TabooRename Scratch 󰙏 <cr>:Codi<bar>:call timer_start(500, execute("RunCode"))<cr>
  aug doubleleaderbinds
    au! doubleleaderbinds
    au FileType norg nnoremap <buffer> <silent> <leader><leader> <cmd>Neorg toggle-concealer<cr><cmd>Neorg toggle-concealer<cr>
    au FileType javascript,javascriptreact,typescript,typescriptreact nnoremap <buffer> <silent> <leader><leader> <cmd>RunClose<cr>:Codi<bar>:call timer_start(500, execute("RunCode"))<cr>
  aug end
]],
	false
)

-- Open links under cursor in browser
if vim.fn.has("macunix") == 1 then
	keymap("n", "gx", "<cmd>silent execute '!open ' . shellescape('<cWORD>')<cr>", opts)
else
	keymap("n", "gx", "<cmd>silent execute '!xdg-open ' . shellescape('<cWORD>')<cr>", opts)
end

-- Navigation
keymap("", "<leader>q", "<cmd>q<cr>", opts) --             close window
keymap("", "<leader>Q", "<cmd>q!<cr>", opts) -- close window and buffer
keymap("n", "<c-v>", "<c-^>", opts) --             toggle recent window
keymap("n", "<c-r>", "<c-w>w", opts) --            navigate next window
keymap("n", "<c-u>", "<c-u>zz", opts) --         scrolls up half buffer
keymap("n", "<c-d>", "<c-d>zz", opts) --       scrolls down half buffer
keymap("n", "<c-a>", "<c-w>W", opts) --        navigate previous window
keymap("", "<c-e>", "<c-y>", opts) --          page scrolls up one line
keymap("", "<c-f>", "<c-e>", opts) --        page scrolls down one line

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
keymap("n", "<c-j>", "gT", opts) --                            prev tab
keymap("n", "<c-k>", "gt", opts) --                            next tab
keymap("n", "<leader>t", "<cmd>tabclose<cr>", opts) --        close tab
keymap("n", "<leader>.", "<cmd>tabmove +1<cr>", opts) --  tab move left
keymap("n", "<leader>,", "<cmd>tabmove -1<cr>", opts) -- tab move right
keymap("n", "<leader>TT", "<cmd>tabo<cr>", opts) --      close all tabs

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

-- Fold commands
keymap("n", "<leader>a", "za", opts) -- toggle fold block
keymap("n", "z<leader>", "zR", opts) -- open all folds
keymap("n", "c<leader>", "zM", opts) -- close all folds

-- Don't yank on delete char
keymap({ "n", "v" }, "x", '"_x', opts)
keymap({ "n", "v" }, "X", '"_X', opts)

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
keymap("n", "<leader>KK", "<cmd>KillKillKill<cr>", opts) --          sheep game
keymap("n", "<c-q>", "<cmd>qa<cr>", opts) --                        exit neovim
keymap("n", "<leader>V", ":verbose map ", { noremap = true }) --  check mapping
keymap({ "n", "x" }, "g<c-x>", "g<c-a>") --                     increase column
keymap({ "n", "x" }, "g<c-z>", "g<c-x>") --                     decrease column
keymap("", "<leader>W", "<cmd>set wrap!<cr>", opts) --          toggle set wrap
keymap("", "<leader>S", "<cmd>set spell!<cr>", opts) --        toggle set spell
keymap("", "<leader>N", "<cmd>set nu!<cr>", opts) --          toggle set number
keymap("n", "<leader><c-q>", "<cmd>qa!<cr>", opts) --         force exit neovim
keymap("", "<leader>Z", "<cmd>set ch=0<cr>", opts) --   set command height to 0
keymap("", "\\<leader>", "g;") --                       go to last changed line
keymap("n", "d<leader>", "cc<esc>", opts) --  clear line without deleting break
keymap({ "n", "x" }, "y", "mzJ`z", opts) -- cursor stay current position when J

-- <esc> and <s-esc> are free

-- Shift char available:
-- Y
-- Z

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
-- r, y
-- <cr>
-- x, m
-- <esc>
-- caps chars (C...)
-- combinations with: j

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

-- \ maps available:
-- y, u, i, o, p
-- h, k, l
-- z, x, b, n

-- q maps available:
-- yank + key

-- Used but mappeable:
-- <leader>n ~ navbuddy
-- <leader>v ~ inlay
-- <leader>t ~ close tab
-- <leader>p ~ treesj
-- <leader>r ~ RunCode
-- <leader>F ~ lazy menu
-- <leader>G ~ code scratch
-- <c-c> ~ (visual) move selected area left
-- <c-v> ~ (visual) move selected area right
