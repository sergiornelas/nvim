local nvim_navic_ok, nvim_navic = pcall(require, "nvim-navic")
local lsp_inlayhints_ok, lsp_inlayhints = pcall(require, "lsp-inlayhints")
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

if not nvim_navic_ok or not lsp_inlayhints_ok or not cmp_nvim_lsp_ok then
	return
end

local keymap = vim.keymap.set
keymap("n", "gq", vim.diagnostic.setloclist, { noremap = true, silent = true })

local keymaps = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	if client.name == "tsserver" or client.name == "sumneko_lua" then
		keymap("n", "gD", vim.lsp.buf.declaration, bufopts)
		keymap("n", "gd", vim.lsp.buf.definition, bufopts)
		-- keymap("n", "gd", "<cmd>TypescriptGoToSourceDefinition<cr>", bufopts)
		keymap("n", "gI", vim.lsp.buf.implementation, bufopts)
		keymap("n", "gS", vim.lsp.buf.signature_help, bufopts)
		keymap("n", "gT", vim.lsp.buf.type_definition, bufopts)
	end

	keymap("n", "gA", vim.lsp.buf.add_workspace_folder, bufopts)
	keymap("n", "gR", vim.lsp.buf.remove_workspace_folder, bufopts)
	keymap("n", "gW", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	keymap("n", "g<leader>", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
	keymap("n", "gL", "<cmd>LspInfo<cr>", bufopts)
end

local M = {}

M.on_attach = function(client, bufnr)
	keymaps(client, bufnr)
	nvim_navic.attach(client, bufnr)
	if client.name == "tsserver" then
		lsp_inlayhints.on_attach(client, bufnr) -- Typescript 4.4+
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
