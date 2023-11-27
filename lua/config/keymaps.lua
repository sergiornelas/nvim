vim.g.mapleader = " "
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- LEADER MAPS ====================================
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
keymap("n", "<leader>7", "<cmd>GrappleSelect key=7<cr>", opts)
keymap("n", "<leader>8", "<cmd>GrappleSelect key=8<cr>", opts)
keymap("n", "<leader>9", "<cmd>GrappleSelect key=9<cr>", opts)
keymap("n", "<leader>0", "<cmd>GrappleSelect key=10<cr>", opts)

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
-- <Code runner>
keymap("n", "<leader>rc", "<cmd>Codi<cr>", opts)
keymap("n", "<leader>re", "<cmd>CodiExpand<cr>", opts)
keymap("n", "<leader>rr", "<cmd>RunCode<cr>", opts)
keymap(
	"n",
	"<leader>J",
	"<cmd>tabnew ~/scratchFiles/scratch.ts<cr><cmd>TabRename Scratch 󰙏 <cr><cmd>RunCode<cr>",
	opts
)
-- <Neorg>
keymap("", "<leader>nn", "<c-w>s<cmd>Neorg workspace todo<cr>", opts)
keymap("", "<leader>nq", "<cmd>Neorg return<cr>", opts)
keymap("", "<leader>nW", ":Neorg workspace ", { noremap = true })
keymap("", "<leader>ni", "<cmd>Neorg index<cr>", opts)
keymap("", "<leader>nt", "<cmd>Neorg toc<cr>", opts)
keymap("", "<leader>nc", "<cmd>Neorg toggle-concealer<cr>", opts)
-- <Typerscript>
keymap("n", "<leader>To", "<cmd>TSToolsOrganizeImports<cr>", opts)
keymap("n", "<leader>Ts", "<cmd>TSToolsSortImports<cr>", opts)
keymap("n", "<leader>TR", "<cmd>TSToolsRemoveUnusedImports<cr>", opts)
keymap("n", "<leader>Tr", "<cmd>TSToolsRemoveUnused<cr>", opts)
keymap("n", "<leader>Ti", "<cmd>TSToolsAddMissingImports<cr>", opts)
keymap("n", "<leader>Tf", "<cmd>TSToolsFixAll<cr>", opts)
-- <Inlay hints>
keymap("n", "<leader>v", function()
	vim.lsp.inlay_hint(0, nil)
end, opts)
-- <Diff view git>
keymap("", "<leader>jf", "<cmd>DiffviewFileHistory %<cr> | <cmd>TabRename FileHistory  <cr>", opts)
keymap("", "<leader>jp", "<cmd>DiffviewFileHistory<cr> | <cmd>TabRename ProjectHistory  <cr>", opts)
-- <Tabby>
keymap("n", "<leader>R", ":TabRename ", { noremap = true })
keymap("n", "<leader>C", "<cmd>TabRename main<cr>", opts)
-- <Lazy>
keymap("n", "<leader>L", "<cmd>Lazy<cr>", opts)
-- <Nvim-tree>
keymap("n", "<leader>a", "<cmd>NvimTreeToggle<cr>", opts)
-- <Mini trailspace>
keymap("", "<leader>b", "<cmd>lua require('mini.trailspace').trim()<cr>", opts)
-- Leader utils
keymap("n", "<leader>>", "<cmd>tabmove +1<cr>", opts) --        tab left
keymap("n", "<leader><", "<cmd>tabmove -1<cr>", opts) --       tab right
keymap("n", "<leader>?", "<cmd>tabclose<cr>", opts) --         tab close
keymap("", "<leader>f", "<cmd>w<cr>", opts) --                 save file
keymap("", "<leader>h", "<cmd>set hlsearch!<cr>", opts) --    highlights
keymap("n", "d<leader>", "cc<esc>", opts) --                  clear line
keymap("", "<leader>W", "<cmd>set wrap!<cr>", opts) --   toggle set wrap
keymap("", "<leader>S", "<cmd>set spell!<cr>", opts) -- toggle set spell
keymap("", "<leader>N", "<cmd>set nu!<cr>", opts) --   toggle set number
keymap("n", "y<leader>", "$T!yt!", opts) --         yank secret password
keymap("n", "<leader><c-q>", "<cmd>qa!<cr>", opts) --  force exit neovim

-- NO LEADER MAPS =================================
-- <Windows>
keymap("n", "<c-w><c-e>", "<cmd>lua require('maximize').toggle()<cr>", opts)
-- <LSP-Signature>
keymap("i", "<c-g>s", function()
	require("lsp_signature").toggle_float_win()
end, opts)
keymap("i", "<c-g><c-s>", function()
	require("lsp_signature").toggle_float_win()
end, opts)
-- <Move>
keymap("v", "<c-j>", ":MoveBlock(1)<cr>", opts)
keymap("v", "<c-k>", ":MoveBlock(-1)<cr>", opts)
-- <Treesitter context>
keymap("n", "g<c-t>", "<cmd>lua require('treesitter-context').go_to_context()<cr>", opts)
-- Utils
keymap("", "<Up>", "<cmd>resize -4<cr>", opts) --                     resize up
keymap("", "<Down>", "<cmd>resize +4<cr>", opts) --                 resize down
keymap("", "<Left>", "<cmd>vertical resize -4<cr>", opts) --        resize left
keymap("", "<Right>", "<cmd>vertical resize +4<cr>", opts) --      resize right
keymap("n", "g<c-k>", "mxO<esc>`x", opts) --                      break line up
keymap("n", "g<c-j>", "mxo<esc>`x", opts) --                    break line down
keymap("n", "gG", "<cmd>%y+<cr>", opts) --                     yank full buffer
keymap("x", "gG", "<esc>VGOgg", opts) --                     select full buffer
keymap({ "n", "x" }, "<c-z>", "<cmd>echo 'Be careful!'<cr>", opts) -- stop exit

-- VIM DEFAULTS REMAPPING =========================
-- <Gitsigns>
vim.api.nvim_exec(
	[[
    nnoremap <expr> <c-j> &diff ? ']c' : "<cmd>Gitsigns next_hunk<cr>" " (vim: same as "j")
    nnoremap <expr> <c-k> &diff ? '[c' : "<cmd>Gitsigns prev_hunk<cr>" " (vim: not used)
  ]],
	false
)
-- <Grapple>
keymap("n", "<c-n>", "<cmd>GrappleCycle forward<cr>", opts) -- (vim: same as "j")
keymap("n", "<c-p>", "<cmd>GrappleCycle backward<cr>", opts) -- (vim: same as "k")
-- <Illuminate>
keymap("n", "<c-g>", "<cmd>lua require('illuminate').goto_next_reference(wrap)<cr>", opts) -- (vim: display current file name and position)
keymap("n", "<c-t>", "<cmd>lua require('illuminate').goto_prev_reference(wrap)<cr>", opts) -- (vim: jump to N older Tag in tag list)
-- <Telescope>
keymap("i", "<c-r>", "<cmd>Telescope registers theme=cursor layout_config={height=0.3}<cr>", opts) -- (vim: insert the contents of a register)
-- <ChatGPT>
keymap("n", "<c-c>", "<cmd>ChatGPT<cr>", opts) -- (vim: interrupt current (search) command)
-- Utils
keymap("n", "<c-q>", "<cmd>qa<cr>", opts) -- (vim: not used, or used for terminal control flow)
