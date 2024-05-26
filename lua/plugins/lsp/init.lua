local M = {
	"neovim/nvim-lspconfig",
	event = "BufReadPost",
	dependencies = {
		{
			"kosayoda/nvim-lightbulb",
			opts = {
				autocmd = { enabled = true, updatetime = 50 },
				sign = {
					enabled = false,
				},
				virtual_text = {
					enabled = true,
				},
			},
		},
	},
}

function M.config()
	local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
	if not lspconfig_ok then
		return
	end

	require("plugins.lsp.diagnostics").setup()
	local on_attach = require("plugins.lsp.handlers").on_attach
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	lspconfig.eslint.setup({
		capabilities = capabilities,
		settings = require("plugins.lsp.settings.eslint").settings,
	})

	lspconfig.cssls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})

	lspconfig.lua_ls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		settings = require("plugins.lsp.settings.sumneko_lua").settings,
	})

	for _, server in ipairs({ "html", "jsonls" }) do
		lspconfig[server].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			init_options = { provideFormatter = false },
		})
	end
end

return M
