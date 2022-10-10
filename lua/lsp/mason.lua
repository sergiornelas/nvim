local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")

if not lspconfig_status_ok then
	return
end

local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
	return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
	return
end

local servers = {
	"sumneko_lua",
	"tsserver",
	"jsonls",
	"cssls",
	"html",
	"bashls",
}

-- This plugin uses the lspconfig server names in the APIs it exposes,
-- not mason.nvim package names (eslint_d, prettierd, stylua).
-- You have to install them manually with MasonInstall.
mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})
mason.setup()

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("lsp.lsp").on_attach,
		capabilities = require("lsp.lsp").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end
