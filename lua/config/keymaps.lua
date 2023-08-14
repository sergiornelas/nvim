vim.g.mapleader = " "
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- <Telescope>
keymap("", "<leader>u", "<cmd>Telescope oldfiles<cr>", opts)
keymap("", "<leader>i", "<cmd>Telescope find_files<cr>", opts)
keymap("", "<leader>o", "<cmd>Telescope buffers<cr>", opts)
keymap("", "<leader>l", "<cmd>Telescope live_grep<cr>", opts)
keymap("", "<leader>k", "<cmd>Telescope git_status<cr>", opts)
keymap("", "<leader>s", "<cmd>Telescope grep_string<cr>", opts)
keymap("", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opts)
keymap("", "<leader>M", "<cmd>Telescope marks theme=ivy<cr>", opts)
keymap("", "<leader>H", "<cmd>Telescope help_tags theme=ivy<cr>", opts)
keymap("i", "<c-r>", "<cmd>Telescope registers theme=cursor layout_config={height=0.3}<cr>", opts)

-- <Grapple>
keymap("n", "<leader>m", "<cmd>GrappleToggle<cr>", opts)
keymap("n", "<leader>p", "<cmd>GrapplePopup tags<cr>", opts)
keymap("n", "<leader>Gk", ":GrappleTag key=", { noremap = true })
keymap("n", "<leader>Gg", ":GrappleTag scope=global key=", { noremap = true })
keymap("n", "<leader>GG", "<c-w>s <cmd>lua require('grapple').popup_tags('global')<cr>", opts)
keymap("n", "<leader>1", "<cmd>GrappleSelect key=1<cr>", opts)
keymap("n", "<leader>2", "<cmd>GrappleSelect key=2<cr>", opts)
keymap("n", "<leader>3", "<cmd>GrappleSelect key=3<cr>", opts)
keymap("n", "<leader>4", "<cmd>GrappleSelect key=4<cr>", opts)
keymap("n", "<leader>5", "<cmd>GrappleSelect key=5<cr>", opts)
keymap("n", "<leader>6", "<cmd>GrappleSelect key=6<cr>", opts)
keymap("n", "<c-p>", "<cmd>GrappleCycle backward<cr>", opts)
keymap("n", "<c-n>", "<cmd>GrappleCycle forward<cr>", opts)

-- <Typerscript>
keymap("n", "<leader>Ti", "<cmd>TypescriptAddMissingImports<cr>", opts)
keymap("n", "<leader>To", "<cmd>TypescriptOrganizeImports<cr>", opts)
keymap("n", "<leader>Tu", "<cmd>TypescriptRemoveUnused<cr>", opts)
keymap("n", "<leader>Tf", "<cmd>TypescriptFixAll<cr>", opts)
keymap("n", "<leader>Tr", "<cmd>TypescriptRenameFile<cr>", opts)
keymap("n", "<leader>Td", "<cmd>TypescriptGoToSourceDefinition<cr>", opts) -- Typescript 4.7+

-- <LSP-Signature>
keymap("i", "<c-s>", function()
	require("lsp_signature").toggle_float_win()
end, opts)

-- <Neorg>
keymap("", "<leader>n", "<c-w>s<cmd>Neorg workspace todo<cr>", opts)
keymap("", ",q", "<cmd>Neorg return<cr>", opts)
keymap("", ",W", ":Neorg workspace ", { noremap = true })
keymap("", ",i", "<cmd>Neorg index<cr>", opts)
keymap("", ",tt", "<cmd>Neorg toc<cr>", opts)
keymap("", ",c", "<cmd>Neorg toggle-concealer<cr>", opts)
keymap("", "<leader>x", ":let &scrolloff=999-&scrolloff<cr><cmd>Twilight<cr>", opts)

-- <Diff view git>
keymap("", "<leader>jf", "<cmd>DiffviewFileHistory %<cr> | <cmd>TabooRename FileHistory  <cr>", opts)
keymap("", "<leader>jp", "<cmd>DiffviewFileHistory<cr> | <cmd>TabooRename ProjectHistory  <cr>", opts)

-- <Move>
keymap("v", "<c-j>", ":MoveBlock(1)<cr>", opts)
keymap("v", "<c-k>", ":MoveBlock(-1)<cr>", opts)
keymap("v", "<c-c>", ":MoveHBlock(-1)<cr>", opts)
keymap("v", "<c-v>", ":MoveHBlock(1)<cr>", opts)

-- <Windows>
keymap("n", "<c-w><c-e>", "<cmd>WindowsMaximize<cr>", opts)
keymap("n", "<c-w><c-a>", "<cmd>WindowsToggleAutowidth<cr>", opts)

-- <Taboo>
keymap("n", "<leader>R", ":TabooRename ", { noremap = true })
keymap("n", "<leader>C", "<cmd>TabooReset<cr>", opts)

-- <Illuminate>
keymap("", "-", "<cmd>lua require('illuminate').goto_next_reference(wrap)<cr>", opts)
keymap("", "+", "<cmd>lua require('illuminate').goto_prev_reference(wrap)<cr>", opts)

-- <Swap-split>
keymap("", "<c-w><c-u>", "<cmd>SwapSplit<cr>", opts)
keymap("", "<c-w>u", "<cmd>SwapSplit<cr>", opts)

-- <Color picker>
keymap("n", "<c-c>", "<cmd>CccPick<cr>", opts)

-- <Lazy>
keymap("n", "<leader>L", "<cmd>Lazy<cr>", opts)

-- <Glance>
keymap("n", "go", "<cmd>Glance references<cr>")

-- <Treesitter context>
keymap("n", "gI", "<cmd>lua require('treesitter-context').go_to_context()<cr>", opts)

-- <Mini trailspace>
keymap("", "<leader>b", "<cmd>lua require('mini.trailspace').trim()<cr>", opts)

-- <Nvim-tree>
keymap("n", "<leader>a", "<cmd>NvimTreeToggle<cr>", opts)

-- <Gitsigns> and next/prev diff line
vim.api.nvim_exec(
	[[
    noremap <expr> J &diff ? ']c' : "<cmd>Gitsigns next_hunk<cr>"
    noremap <expr> K &diff ? '[c' : "<cmd>Gitsigns prev_hunk<cr>"
  ]],
	false
)

-- <Codi-Runner> and <Neorg> refresh (Codi suspended temporally)
keymap(
	"n",
	"<leader>J",
	"<cmd>tabnew ~/scratchFiles/scratch.ts<cr><cmd>TabooRename Scratch 󰙏 <cr><cmd>RunCode<cr>",
	opts
)
vim.api.nvim_exec(
	[[
  " nnoremap <leader>J :tabnew ~/scratchFiles/scratch.ts<cr>:TabooRename Scratch 󰙏 <cr>:Codi<bar>:call timer_start(500, execute("RunCode"))<cr>
  aug doubleleaderbinds
    au! doubleleaderbinds
    au FileType norg nnoremap <buffer> <silent> <leader><leader> <cmd>Neorg toggle-concealer<cr><cmd>Neorg toggle-concealer<cr>
    " au FileType javascript,javascriptreact,typescript,typescriptreact nnoremap <buffer> <silent> <leader><leader> <cmd>RunClose<cr>:Codi<bar>:call timer_start(500, execute("RunCode"))<cr>
    au FileType javascript,javascriptreact,typescript,typescriptreact nnoremap <buffer> <silent> <leader><leader> <cmd>RunClose<cr><cmd>RunCode<cr>
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
keymap("", "<leader>w", "<cmd>q<cr>", opts) --             close window
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
keymap("n", "<c-h>", "<cmd>tabclose<cr>", opts) --            close tab
keymap("n", "<leader>>", "<cmd>tabmove +1<cr>", opts) --  tab move left
keymap("n", "<leader><", "<cmd>tabmove -1<cr>", opts) -- tab move right
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
keymap("n", "z<leader>", "zR", opts) -- open all folds
keymap("n", "c<leader>", "zM", opts) -- close all folds

-- Don't yank on delete char
keymap({ "n", "v" }, "x", '"_x', opts)
keymap({ "n", "v" }, "X", '"_X', opts)

-- Switch jumps
keymap("n", "<c-o>", "<c-i>zz", opts)
keymap("n", "<c-i>", "<c-o>zz", opts)

-- Switch middle cursor
keymap("n", "gm", "gM", opts)
keymap("n", "gM", "gm", opts)

-- Utils
keymap("", "<leader>f", "<cmd>w<cr>", opts) --                        save file
keymap("", "<leader>h", "<cmd>set hlsearch!<cr>", opts) --           highlights
keymap("n", "<c-q>", "<cmd>qa<cr>", opts) --                        exit neovim
keymap("n", "<leader>V", ":verbose map ", { noremap = true }) --  check mapping
keymap({ "n", "x" }, "g<c-x>", "g<c-a>") --                     increase column
keymap({ "n", "x" }, "g<c-z>", "g<c-x>") --                     decrease column
keymap("", "<leader>W", "<cmd>set wrap!<cr>", opts) --          toggle set wrap
keymap("", "<leader>S", "<cmd>set spell!<cr>", opts) --        toggle set spell
keymap("", "<leader>N", "<cmd>set nu!<cr>", opts) --          toggle set number
keymap("n", "<leader><c-q>", "<cmd>qa!<cr>", opts) --         force exit neovim
keymap("n", "<c-w><c-q>", "<cmd>wq<cr>", opts) --          save and exit neovim
keymap("n", "q<leader>", "$T!yt!", opts) --                yank secret password
keymap("n", "<leader><c-h>", "<cmd>bd!<cr>", opts) --     delete written buffer
keymap("", "<leader>Z", "<cmd>set ch=0<cr>", opts) --   set command height to 0
keymap("", "\\<leader>", "g;") --                       go to last changed line
keymap("", "g,", "gi", opts) --                 go to last insert mode position
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
-- y, i (goes insert where stopped) p
-- <cr>
-- caps chars

-- <leader> maps available:
-- q, r, y
-- d, <cr>
-- v
-- <esc>
-- caps chars (C...)
-- combinations with: j, t

-- <C-> maps available:
-- y
-- s
-- b, m
-- <cr>

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
-- j, h, k, l
-- z, x, b, n, m

-- q maps available:
-- yank + key

-- Used but mappeable:
-- <leader>v ~ inlay
-- <leader>x ~ neorg twilight mode
