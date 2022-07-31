local saga = require("lspsaga")

saga.init_lsp_saga({
	border_style = "rounded",
	diagnostic_header = { " 😡", "😬", " 👁️", " 🌝" },
	max_preview_lines = 30,
	code_action_icon = "*",
	code_action_lightbulb = {
		sign = false,
	},
	finder_icons = {
		def = "🐔 ",
		ref = "🐤 ",
	},
	finder_action_keys = {
		open = "<cr>",
		vsplit = "<c-v>",
		split = "<c-s>",
		scroll_down = "<C-f>",
		scroll_up = "<C-e>",
		quit = "<leader>q",
	},
	code_action_keys = {
		quit = "<leader>q",
	},
	definition_preview_icon = "🛰️ ",
})

-- go Implementation
-- word definition and reference
vim.keymap.set("n", "gi", "<cmd>Lspsaga lsp_finder<CR>", { silent = true, noremap = true })
-- preview definition (unique)
vim.keymap.set("n", "gp", "<cmd>Lspsaga preview_definition<CR>", { silent = true })
-- hover
vim.keymap.set("n", "gh", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
-- signatureHelp
vim.keymap.set("n", "gs", "<Cmd>Lspsaga signature_help<CR>", { silent = true, noremap = true })
-- code action
vim.keymap.set("n", "ga", "<cmd>Lspsaga code_action<CR>", { silent = true, noremap = true })
-- rename
vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true, noremap = true })
-- jump and show diagnostics
vim.keymap.set("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true, noremap = true })
-- next/prev diagnostic
vim.cmd([[
  nnoremap \e <CMD>Lspsaga diagnostic_jump_prev<CR>
  nnoremap \f <CMD>Lspsaga diagnostic_jump_next<CR>
]])
