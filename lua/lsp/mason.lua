local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
	return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
	return
end

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
	return
end

local servers = {
	"bashls",
	"cssls",
	"html",
	"jsonls",
	"sumneko_lua",
	"tsserver",
}

mason.setup()
-- This plugin uses the lspconfig server names in the APIs it exposes,
-- not mason.nvim package names (eslint_d, prettierd, stylua).
-- You have to install them manually with MasonInstall.
mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local opts = {}
for _, server in pairs(servers) do
	opts = {
		on_attach = require("lsp.lsp").on_attach,
		capabilities = require("lsp.lsp").capabilities,
	}
	server = vim.split(server, "@")[1]
	local server_opts_ok, server_opts = pcall(require, "lsp.settings." .. server)
	if server_opts_ok then
		opts = vim.tbl_deep_extend("force", server_opts, opts)
	end
	lspconfig[server].setup(opts)
end
