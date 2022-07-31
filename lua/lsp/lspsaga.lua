local saga = require("lspsaga")

saga.init_lsp_saga({
	border_style = "rounded",
	saga_winblend = 12,
	diagnostic_header = { " 😡", " ⚠️", " 👁️", " 🌝" },
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
	},
	definition_preview_icon = "🛰️ ",
})

-- word definition and reference
vim.keymap.set("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", { silent = true, noremap = true })
-- code action
vim.keymap.set("n", "<leader>lj", "<cmd>Lspsaga code_action<CR>", { silent = true, noremap = true })
-- hover
vim.keymap.set("n", "<leader>lh", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
-- signatureHelp
vim.keymap.set("n", "<leader>ls", "<Cmd>Lspsaga signature_help<CR>", { silent = true, noremap = true })
-- rename
vim.keymap.set("n", "<leader>lr", "<cmd>Lspsaga rename<CR>", { silent = true, noremap = true })
-- jump and show diagnostics
vim.keymap.set("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true, noremap = true })
-- next/prev diagnostic
vim.cmd([[
  nnoremap \e <CMD>Lspsaga diagnostic_jump_prev<CR>
  nnoremap \f <CMD>Lspsaga diagnostic_jump_next<CR>
]])
-- preview definition (unique)
vim.keymap.set("n", "<leader>ld", "<cmd>Lspsaga preview_definition<CR>", { silent = true })
