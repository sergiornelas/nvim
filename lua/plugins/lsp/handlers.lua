local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

if not cmp_nvim_lsp_ok then
	return
end

local keymap = vim.keymap.set

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		local lsp = vim.lsp.buf
		local opts = { buffer = ev.buf }
		-- keymap("n", "gD", lsp.declaration, bufopts)
		keymap("n", "gD", "<cmd>TSToolsGoToSourceDefinition<cr>", opts)
		keymap("n", "gz", lsp.implementation, opts)
		keymap("n", "gs", lsp.signature_help, opts)
		keymap("n", "gA", lsp.add_workspace_folder, opts)
		keymap("n", "gF", lsp.remove_workspace_folder, opts)
		keymap("n", "gW", function()
			print(vim.inspect(lsp.list_workspace_folders()))
		end, opts)
		keymap("n", "gf", lsp.type_definition, opts)
		-- keymap("n", "gR", lsp.references, opts)
		keymap("n", "g;", function()
			lsp.format({ async = true })
		end, opts)

		-- <Lspsaga>
		keymap("n", "g<leader>", "<cmd>Lspsaga code_action<cr>", opts)
		keymap("n", "gp", "<cmd>Lspsaga peek_definition<cr>", opts)
		keymap("n", "gd", "<cmd>Lspsaga goto_definition<cr>", opts)
		keymap("n", "gw", "<cmd>Lspsaga show_cursor_diagnostics<cr>", opts)
		keymap("n", "gl", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
		keymap("n", "gq", "<cmd>Lspsaga show_buf_diagnostics<cr>", opts)
		keymap("n", "gQ", "<cmd>Lspsaga show_workspace_diagnostics<cr>", opts)
		keymap("n", "\\e", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
		keymap("n", "\\d", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
		keymap("n", "\\r", function()
			require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
		end, opts)
		keymap("n", "\\f", function()
			require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
		end, opts)
		keymap("n", "go", "<cmd>Lspsaga finder<cr>", opts)
		keymap("n", "gh", "<cmd>Lspsaga hover_doc<cr>", opts)
		keymap("n", "gH", "<cmd>Lspsaga hover_doc ++keep<cr>", opts)
		keymap("n", "gO", "<cmd>Lspsaga outline<cr>", opts)
		keymap("n", "gr", "<cmd>Lspsaga rename<cr>", opts)
		keymap("n", "gR", ":Lspsaga project_replace ", { noremap = true })
	end,
	keymap("n", "gL", "<cmd>LspInfo<cr>"),
})

local M = {}

M.on_attach = function(client, bufnr)
	if client.server_capabilities.inlayHintProvider then
		require("lsp-inlayhints").on_attach(client, bufnr) -- Typescript 4.4
		-- vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#747D83", bg = "#333232", italic = true })
		-- -- enable/disable on insert mode:
		-- local inlay_hints_group = vim.api.nvim_create_augroup("InlayHints", { clear = false })
		-- local mode = vim.api.nvim_get_mode().mode
		-- vim.lsp.inlay_hint(bufnr, mode == "n" or mode == "v")
		-- vim.api.nvim_create_autocmd("InsertEnter", {
		-- 	group = inlay_hints_group,
		-- 	buffer = bufnr,
		-- 	callback = function()
		-- 		vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#747D83", bg = "#333232", italic = true })
		-- 		vim.lsp.inlay_hint(bufnr, false)
		-- 	end,
		-- })
		-- vim.api.nvim_create_autocmd("InsertLeave", {
		-- 	group = inlay_hints_group,
		-- 	buffer = bufnr,
		-- 	callback = function()
		-- 		vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#747D83", bg = "#333232", italic = true })
		-- 		vim.lsp.inlay_hint(bufnr, true)
		-- 	end,
		-- })
		-- -- toggle manually
		-- keymap(
		-- 	"n",
		-- 	"<leader>v",
		-- 	"<cmd>lua vim.lsp.inlay_hint(" .. bufnr .. ", true)<cr>",
		-- 	{ noremap = true, silent = true }
		-- )
		-- keymap(
		-- 	"n",
		-- 	"<leader>r",
		-- 	"<cmd>lua vim.lsp.inlay_hint(" .. bufnr .. ", false)<cr>",
		-- 	{ noremap = true, silent = true }
		-- )
	end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
