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
keymap("", "<leader>I", "<cmd>Telescope import<cr>", opts)

-- <Grapple>
keymap("n", "<leader>m", "<cmd>GrappleToggle<cr>", opts)
keymap("n", "<leader>p", "<cmd>GrapplePopup tags<cr>", opts)
keymap("n", "<leader>Gj", ":GrappleTag key=", { noremap = true })
keymap("n", "<leader>Gg", ":GrappleTag scope=global key=", { noremap = true })
keymap("n", "<leader>GG", "<c-w>s <cmd>lua require('grapple').popup_tags('global')<cr>", opts)
keymap("n", "<leader>1", "<cmd>GrappleSelect key=1<cr>", opts)
keymap("n", "<leader>2", "<cmd>GrappleSelect key=2<cr>", opts)
keymap("n", "<leader>3", "<cmd>GrappleSelect key=3<cr>", opts)
keymap("n", "<leader>4", "<cmd>GrappleSelect key=4<cr>", opts)
keymap("n", "<leader>5", "<cmd>GrappleSelect key=5<cr>", opts)
keymap("n", "<leader>6", "<cmd>GrappleSelect key=6<cr>", opts)

-- <Typerscript>
keymap("n", "<leader>To", "<cmd>TSToolsOrganizeImports<cr>", opts)
keymap("n", "<leader>Ts", "<cmd>TSToolsSortImports<cr>", opts)
keymap("n", "<leader>TR", "<cmd>TSToolsRemoveUnusedImports<cr>", opts)
keymap("n", "<leader>Tr", "<cmd>TSToolsRemoveUnused<cr>", opts)
keymap("n", "<leader>Ti", "<cmd>TSToolsAddMissingImports<cr>", opts)
keymap("n", "<leader>Tf", "<cmd>TSToolsFixAll<cr>", opts)

-- <Neorg>
keymap("", "<leader>nn", "<c-w>s<cmd>Neorg workspace todo<cr>", opts)
keymap("", "<leader>nq", "<cmd>Neorg return<cr>", opts)
keymap("", "<leader>nW", ":Neorg workspace ", { noremap = true })
keymap("", "<leader>ni", "<cmd>Neorg index<cr>", opts)
keymap("", "<leader>nt", "<cmd>Neorg toc<cr>", opts)
keymap("", "<leader>nc", "<cmd>Neorg toggle-concealer<cr>", opts)
keymap("", "<leader>x", ":let &scrolloff=999-&scrolloff<cr><cmd>Twilight<cr>", opts)

-- <LSP-Signature>
keymap("i", "<c-s><leader>", function()
	require("lsp_signature").toggle_float_win()
end, opts)

-- <Diff view git>
keymap("", "<leader>jf", "<cmd>DiffviewFileHistory %<cr> | <cmd>TabRename FileHistory  <cr>", opts)
keymap("", "<leader>jp", "<cmd>DiffviewFileHistory<cr> | <cmd>TabRename ProjectHistory  <cr>", opts)

-- <Move>
keymap("v", "<c-j>", ":MoveBlock(1)<cr>", opts)
keymap("v", "<c-k>", ":MoveBlock(-1)<cr>", opts)

-- <Gitsigns>
vim.api.nvim_exec(
	[[
    nnoremap <expr> <c-j> &diff ? ']c' : "<cmd>Gitsigns next_hunk<cr>" " (vim: same as "j")
    nnoremap <expr> <c-k> &diff ? '[c' : "<cmd>Gitsigns prev_hunk<cr>" " (vim: not used)
  ]],
	false
)

-- <Illuminate>
keymap("n", "<c-g>", "<cmd>lua require('illuminate').goto_next_reference(wrap)<cr>", opts) -- (vim: display current file name and position)
keymap("n", "<c-t>", "<cmd>lua require('illuminate').goto_prev_reference(wrap)<cr>", opts) -- (vim: jump to N older Tag in tag list)

-- <Grapple>
keymap("n", "<c-p>", "<cmd>GrappleCycle backward<cr>", opts) -- (vim: same as "k")
keymap("n", "<c-n>", "<cmd>GrappleCycle forward<cr>", opts) -- (vim: same as "j")

-- <Windows>
keymap("n", "<c-w><c-e>", "<cmd>WindowsMaximize<cr>", opts)
keymap("n", "<c-w><c-a>", "<cmd>WindowsToggleAutowidth<cr>", opts)

-- <Tabby>
keymap("n", "<leader>R", ":TabRename ", { noremap = true })
keymap("n", "<leader>C", "<cmd>TabRename main<cr>", opts)

-- <Swap-split>
keymap("", "<c-w><c-u>", "<cmd>SwapSplit<cr>", opts)
keymap("", "<c-w>u", "<cmd>SwapSplit<cr>", opts)

-- <Lazy>
keymap("n", "<leader>L", "<cmd>Lazy<cr>", opts)

-- <ChatGPT>
-- keymap("n", "<leader>q", "<cmd>ChatGPT<cr>", opts)

-- <Inlay hints>
keymap("n", "<leader>v", function()
	vim.lsp.inlay_hint(0, nil)
end, opts)

-- <Treesitter context>
keymap("n", "[t", "<cmd>lua require('treesitter-context').go_to_context()<cr>", opts)

-- <Mini trailspace>
keymap("", "<leader>b", "<cmd>lua require('mini.trailspace').trim()<cr>", opts)

-- <Nvim-tree>
keymap("n", "<leader>a", "<cmd>NvimTreeToggle<cr>", opts)

-- <Code runner>
keymap("n", "<leader>rc", "<cmd>Codi<cr>", opts)
keymap("n", "<leader>re", "<cmd>CodiExpand<cr>", opts)
keymap("n", "<leader>rr", "<cmd>RunCode<cr>", opts)

-- <Codi-Runner> and <Neorg> refresh (Codi suspended temporally)
keymap(
	"n",
	"<leader>J",
	"<cmd>tabnew ~/scratchFiles/scratch.ts<cr><cmd>TabRename Scratch 󰙏 <cr><cmd>RunCode<cr>",
	opts
)

-- vim.api.nvim_exec(
-- 	[[
--   " nnoremap <leader>J :tabnew ~/scratchFiles/scratch.ts<cr>:TabRename Scratch 󰙏 <cr>:Codi<bar>:call timer_start(500, execute("RunCode"))<cr>
--   " aug doubleleaderbinds
--     " au! doubleleaderbinds
--     " au FileType norg nnoremap <buffer> <silent> <leader><leader> <cmd>Neorg toggle-concealer<cr><cmd>Neorg toggle-concealer<cr>
--     " au FileType javascript,javascriptreact,typescript,typescriptreact nnoremap <buffer> <silent> <leader><leader> <cmd>RunClose<cr>:Codi<bar>:call timer_start(500, execute("RunCode"))<cr>
--     " au FileType javascript,javascriptreact,typescript,typescriptreact nnoremap <buffer> <silent> <leader><leader> <cmd>RunClose<cr><cmd>RunCode<cr>
--   " aug end
-- ]],
-- 	false
-- )

-- Open links under cursor in browser
if vim.fn.has("macunix") == 1 then
	keymap("n", "gy", "<cmd>silent execute '!open ' . shellescape('<cWORD>')<cr>", opts)
else
	keymap("n", "gy", "<cmd>silent execute '!xdg-open ' . shellescape('<cWORD>')<cr>", opts)
end

-- Navigation
-- keymap("", "<leader>w", "<cmd>q<cr>", opts) --             close window

-- Resize window
keymap("", "<Left>", "<cmd>vertical resize -4<cr>", opts)
keymap("", "<Up>", "<cmd>resize -4<cr>", opts)
keymap("", "<Down>", "<cmd>resize +4<cr>", opts)
keymap("", "<Right>", "<cmd>vertical resize +4<cr>", opts)

-- Tabs
keymap("n", "<leader>>", "<cmd>tabmove +1<cr>", opts) --  tab move left
keymap("n", "<leader><", "<cmd>tabmove -1<cr>", opts) -- tab move right

-- Visual mode
keymap("x", "<leader>p", '"_dP', opts) -- paste and don't register

-- Lua snip conflicts
keymap("s", "<c-h>", "<BS>i", opts)
keymap("s", "q", "q", opts)
keymap("s", "#", "#", opts)
keymap("s", "*", "*", opts)

-- Utils
keymap("", "<leader>f", "<cmd>w<cr>", opts) --                        save file
keymap("", "<leader>h", "<cmd>set hlsearch!<cr>", opts) --           highlights
keymap("n", "<c-q>", "<cmd>qa<cr>", opts) --                        exit neovim
keymap("n", "g<cr>", "mzO<esc>`z", opts) --                       break line up
keymap("n", "<leader>V", ":verbose map ", { noremap = true }) --  check mapping
keymap("", "<leader>W", "<cmd>set wrap!<cr>", opts) --          toggle set wrap
keymap("", "<leader>S", "<cmd>set spell!<cr>", opts) --        toggle set spell
keymap("", "<leader>N", "<cmd>set nu!<cr>", opts) --          toggle set number
keymap("n", "<leader><c-q>", "<cmd>qa!<cr>", opts) --         force exit neovim
keymap("n", "<leader><c-h>", "<cmd>bd!<cr>", opts) --     delete written buffer
keymap("n", "<leader><leader>", "i<space><esc>", opts) -- one space normal mode
keymap("x", "<leader><leader>", "I<space><esc>", opts) -- one space visual mode
keymap("", "<leader>Z", "<cmd>set ch=1<cr>", opts) --   set command height to 0
keymap("n", "d<leader>", "cc<esc>", opts) --  clear line without deleting break

-- ========== VIM DEFAULTS REMAP ========= :h index
-- <Telescope>
keymap("i", "<c-r>", "<cmd>Telescope registers theme=cursor layout_config={height=0.3}<cr>", opts) -- (vim: insert the contents of a register)
-- Utils
keymap("n", "<cr>", "mzo<esc>`z", opts) --  break line (vim: cursor to the first CHAR N lines lower)
keymap("n", "y<leader>", "$T!yt!", opts) -- yank secret password (vim: record typed characters into named register {0-9a-zA-Z"} (uppercase to append))
keymap({ "n", "x" }, "<c-z>", "<cmd>echo 'Be careful!'<cr>", opts)
-- Don't yank on delete char
-- keymap({ "n", "v" }, "x", '"_x', opts) -- (vim: delete the highlighted area)
-- keymap({ "n", "v" }, "X", '"_X', opts) -- (vim: delete the highlighted lines)

-- ========== MAPPING AVAILABLE =====
-- <leader> maps available:
-- y
-- d, <cr>
-- <leader> (space right)
-- <esc>
-- caps chars (C...)
-- inverse: z, c
-- combinations with: j, t

-- <C-> maps available:
-- y, p (go to last edited)
-- c, m (used as enter)
-- <cr>

-- Shift char available:
-- Y
-- Z

-- D maps available:
-- q, y, p
-- <cr>
-- z, x, c, v?, m

-- C maps available:
-- r, y, u, p
-- d, g, <cr>
-- z, m

-- G maps available:
-- c, .
-- caps chars

-- visual maps available:
-- x, v, m

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
-- spacebar

-- q maps available:
-- yank + key

-- Used but mappeable:
-- <leader><leader> ~ space right
-- <leader>v ~ inlay
-- <leader>r ~ runcode commands
-- <leader>x ~ neorg twilight mode
-- <c-p> ~ go to last edited line
-- tab arrow keys
