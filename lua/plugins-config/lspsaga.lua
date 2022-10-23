local lspsaga_ok, lspsaga = pcall(require, "lspsaga")
if not lspsaga_ok then
	return
end

lspsaga.init_lsp_saga({
	border_style = "bold",
	diagnostic_header = { " 😡 ", " 😬 ", " 👁️ ", " 🌚 " },
	move_in_saga = { prev = "<C-o>", next = "<C-i>" },
	max_preview_lines = 30,
	code_action_icon = "*",
	code_action_lightbulb = {
		enable = false,
	},
	finder_icons = {
		def = "🐔 ",
		ref = "🐤 ",
	},
	finder_action_keys = {
		open = "<c-j>",
		vsplit = "<c-v>",
		split = "<c-s>",
		tabe = "<c-k>",
		quit = "<esc>",
	},
	definition_action_keys = {
		edit = "<c-j>",
		vsplit = "<c-v>",
		split = "<c-s>",
		tabe = "<c-k>",
		quit = "<esc>",
	},
	code_action_keys = {
		quit = "<esc>",
	},
	rename_action_quit = "<esc>",
	symbol_in_winbar = {
		enable = false,
	},
	show_outline = {
		jump_key = "<c-j>",
	},
})

vim.keymap.set({ "n", "x" }, "gk", "<cmd>Lspsaga lsp_finder<CR>", { silent = true, noremap = true })
vim.keymap.set({ "n", "x" }, "gc", "<cmd>Lspsaga code_action<CR>", { silent = true, noremap = true })
vim.keymap.set({ "n", "x" }, "gh", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
vim.keymap.set({ "n", "x" }, "gr", "<cmd>Lspsaga rename<CR>", { silent = true, noremap = true })
vim.keymap.set({ "n", "x" }, "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true, noremap = true })
vim.keymap.set({ "n", "x" }, "gp", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
vim.keymap.set({ "n", "x" }, "\\e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true, noremap = true })
vim.keymap.set({ "n", "x" }, "\\f", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true, noremap = true })
vim.keymap.set({ "n", "x" }, "gz", "<cmd>LSoutlineToggle<CR>", { silent = true, noremap = true })
