local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local servers = {
	"sumneko_lua",
	"cssls",
	"html",
	"tsserver",
	"bashls",
	"jsonls",
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

	if server == "sumneko_lua" then
		local sumneko_opts = require("lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server == "tsserver" then
		local sumneko_opts = require("lsp.settings.tsserver")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	lspconfig[server].setup(opts)
end

-- If one day you want to tinker tsserver
-- lspconfig.tsserver.setup({
-- 	filetypes = {
-- 		"javascriptreact",
-- 		"javascript",
-- 		"typescript",
-- 		"typescriptreact",
-- 	},
-- })
