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
	local lsp = vim.lsp.buf

	if client.name == "tsserver" or client.name == "lua_ls" then
		-- keymap"n", "gD", lsp_buf.declaration, bufopts
		keymap("n", "gd", lsp.definition, bufopts)
		keymap("n", "gD", "<cmd>TypescriptGoToSourceDefinition<cr>", bufopts)
		keymap("n", "gI", lsp.implementation, bufopts)
		keymap("n", "gs", lsp.signature_help, bufopts)
		keymap("n", "gt", lsp.type_definition, bufopts)
	end

	keymap("n", "gA", lsp.add_workspace_folder, bufopts)
	keymap("n", "gF", lsp.remove_workspace_folder, bufopts)
	keymap("n", "gW", function()
		print(vim.inspect(lsp.list_workspace_folders()))
	end, bufopts)
	keymap("n", "g<leader>", function()
		lsp.format({ async = true })
	end, bufopts)
	keymap("n", "gL", "<cmd>LspInfo<cr>", bufopts)
end

local M = {}

M.on_attach = function(client, bufnr)
	keymaps(client, bufnr)
	nvim_navic.attach(client, bufnr)
	require("nvim-navbuddy").attach(client, bufnr)
	if client.name == "tsserver" then
		lsp_inlayhints.on_attach(client, bufnr) -- Typescript 4.4+
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
