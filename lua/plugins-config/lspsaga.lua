local saga = require("lspsaga")

saga.init_lsp_saga({
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
	code_action_keys = {
		quit = "<esc>",
	},
	rename_action_quit = "<esc>",
})

vim.keymap.set("n", "gi", "<cmd>Lspsaga lsp_finder<CR>", { silent = true, noremap = true }) --definition and reference
vim.keymap.set("n", "gc", "<cmd>Lspsaga code_action<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "gh", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "go", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
vim.keymap.set("n", "\\e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "\\f", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true, noremap = true })
