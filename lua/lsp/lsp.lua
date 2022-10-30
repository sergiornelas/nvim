local M = {}

local nvim_navic_ok, nvim_navic = pcall(require, "nvim-navic")
if not nvim_navic_ok then
	return
end

local lsp_inlayhints_ok, lsp_inlayhints = pcall(require, "lsp-inlayhints")
if not lsp_inlayhints_ok then
	return
end

local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_ok then
	return
end

-- LSP options
M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "🔥" },
		{ name = "DiagnosticSignHint", text = "💡" },
		{ name = "DiagnosticSignInfo", text = "ℹ️" },
		{ name = "DiagnosticSignWarn", text = "⚠️" },
	}
	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end
	vim.diagnostic.config({
		virtual_text = true, -- disable virtual text
		signs = {
			active = signs, -- show signs
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	})
end

-- LSP keymaps
local keymap = vim.keymap.set
keymap("n", "gq", vim.diagnostic.setloclist, { noremap = true, silent = true })
keymap("n", "<leader>dA", ":TypescriptAddMissingImports<CR>")
keymap("n", "<leader>dO", ":TypescriptOrganizeImports<CR>")
keymap("n", "<leader>dU", ":TypescriptRemoveUnused<CR>")
keymap("n", "<leader>dF", ":TypescriptFixAll<CR>")
keymap("n", "<leader>dR", ":TypescriptRenameFile<CR>")
keymap("n", "<leader>dg", ":TypescriptGoToSourceDefinition<CR>") -- Typescript 4.7+

local function lsp_keymaps(bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	keymap("n", "gD", vim.lsp.buf.declaration, bufopts)
	keymap("n", "gd", vim.lsp.buf.definition, bufopts)
	keymap("n", "gI", vim.lsp.buf.implementation, bufopts)
	keymap("n", "gS", vim.lsp.buf.signature_help, bufopts)
	keymap("n", "gA", vim.lsp.buf.add_workspace_folder, bufopts)
	keymap("n", "gR", vim.lsp.buf.remove_workspace_folder, bufopts)
	keymap("n", "gW", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	keymap("n", "gt", vim.lsp.buf.type_definition, bufopts)
	keymap("n", "g<leader>", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
	keymap("n", "gL", "<cmd>LspInfo<cr>", bufopts)
end

-- LSP highlight objects
local function lsp_highlight_document(client, bufnr)
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
		vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
		vim.api.nvim_create_autocmd("CursorHold", {
			callback = vim.lsp.buf.document_highlight,
			buffer = bufnr,
			group = "lsp_document_highlight",
			desc = "Document Highlight",
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			callback = vim.lsp.buf.clear_references,
			buffer = bufnr,
			group = "lsp_document_highlight",
			desc = "Clear All the References",
		})
	end
end

-- LSP attach all features
M.on_attach = function(client, bufnr)
	lsp_keymaps(bufnr) -- LSP keymaps
	lsp_highlight_document(client, bufnr) -- LSP highlight current object
	nvim_navic.attach(client, bufnr) -- Objects on status bar

	if client.name == "tsserver" then
		lsp_inlayhints.on_attach(client, bufnr) -- Inlay hints (Typescript 4.4+)
		-- Formatting disabled for performance (maybe) and prettierd is active in null-ls:
		client.server_capabilities.documentFormattingProvider = false
	end
end

-- LSP capabilities
M.capabilities = cmp_nvim_lsp.default_capabilities()

return M
