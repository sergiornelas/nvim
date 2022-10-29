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

local keymap = vim.keymap.set

keymap("n", "gk", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
keymap({ "n", "x" }, "gc", "<cmd>Lspsaga code_action<CR>", { silent = true })
keymap("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })
keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
keymap("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
keymap("n", "gw", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
keymap("n", "\\e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
keymap("n", "\\f", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
keymap("n", "\\g", function()
	require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
keymap("n", "\\v", function()
	require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
keymap("n", "gz", "<cmd>LSoutlineToggle<CR>", { silent = true })
keymap("n", "gh", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
