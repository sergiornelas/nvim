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

		vim.lsp.enable({ "lua_ls", "eslint", "jsonls", "cssls", "html", "yamlls", "vtsls", "tsgo" })

		vim.lsp.config("vtsls", {
			on_attach = on_attach,
			settings = require("plugins.lsp.settings.vtsls").settings,
		})

		-- Disable diagnostics from vtsls
		local default_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]
		vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
			local client = vim.lsp.get_client_by_id(ctx.client_id)
			if client and client.name == "vtsls" then
				return -- silence vtsls diagnostics
			end
			return default_handler(err, result, ctx, config)
		end

		vim.lsp.config("tsgo", {
			on_attach = function(client)
				require("plugins.lsp.capabilities.tsgo").apply(client)
			end,
		})

		vim.lsp.config("lua_ls", {
			on_attach = on_attach,
			settings = require("plugins.lsp.settings.lua_ls").settings,
		})

		vim.lsp.config("eslint", {
			settings = require("plugins.lsp.settings.eslint").settings,
		})

		vim.lsp.config("jsonls", {
			on_attach = on_attach,
			init_options = { provideFormatter = false },
		})

		vim.lsp.config("cssls", {
			on_attach = on_attach,
		})

		vim.lsp.config("html", {
			on_attach = on_attach,
			init_options = { provideFormatter = false },
		})
	end,
}
