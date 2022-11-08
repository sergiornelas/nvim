local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
local typescript_ok, typescript = pcall(require, "typescript")

if not lspconfig_ok or not typescript_ok then
	return
end

local on_attach = require("lsp.handlers").on_attach
local capabilities = require("lsp.handlers").capabilities

typescript.setup({
	server = {
		on_attach = on_attach,
		capabilities = capabilities,
		settings = require("lsp.settings.tsserver").settings,
		-- root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "node_modules"),
	},
})

lspconfig.eslint.setup({
	on_attach = function(_, bufnr)
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	end,
	capabilities = capabilities,
	settings = require("lsp.settings.eslint").settings,
})

lspconfig.cssls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = require("lsp.settings.sumneko_lua").settings,
})

for _, server in ipairs({ "html", "jsonls" }) do
	lspconfig[server].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		init_options = { provideFormatter = false },
	})
end
