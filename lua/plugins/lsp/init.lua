return {
	"neovim/nvim-lspconfig",
	event = "BufReadPost",
	dependencies = {
		{
			"kosayoda/nvim-lightbulb",
			opts = {
				priority = 4501,
				autocmd = { enabled = true, updatetime = 50 },
				sign = {
					enabled = false,
				},
				virtual_text = {
					enabled = true,
					text = "󰌵",
				},
			},
		},
	},
	config = function()
		require("plugins.lsp.diagnostics").setup()
		local on_attach = require("plugins.lsp.handlers").on_attach
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		vim.lsp.enable({ "lua_ls", "eslint", "jsonls", "cssls", "html" })

		vim.lsp.config("lua_ls", {
			on_attach = on_attach,
			capabilities = capabilities,
			settings = require("plugins.lsp.settings.lua_ls").settings,
		})

		vim.lsp.config("eslint", {
			settings = require("plugins.lsp.settings.eslint").settings,
			capabilities = capabilities,
		})

		vim.lsp.config("jsonls", {
			on_attach = on_attach,
			capabilities = capabilities,
			init_options = { provideFormatter = false },
		})

		vim.lsp.config("cssls", {
			on_attach = on_attach,
			capabilities = capabilities,
		})

		vim.lsp.config("html", {
			on_attach = on_attach,
			capabilities = capabilities,
			init_options = { provideFormatter = false },
		})
	end,
}
