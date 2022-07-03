local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local servers = {
	"sumneko_lua",
	"cssls",
	"html",
	-- "tsserver",
	"bashls",
	"jsonls",
	"yamlls",
}

lsp_installer.setup()

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("lsp.handlers").on_attach,
		capabilities = require("lsp.handlers").capabilities,
	}

	-- if server == "tsserver" then
	-- 	local tsserver_opts = require("lsp.settings.tsserver")
	-- 	opts = vim.tbl_deep_extend("force", tsserver, opts)
	-- end

	if server == "sumneko_lua" then
		local sumneko_opts = require("lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server == "pyright" then
		local pyright_opts = require("lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end

	lspconfig[server].setup(opts)
end
