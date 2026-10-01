return {
	"neovim/nvim-lspconfig",
	lazy = false,
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
		local config = vim.lsp.config

		-- npm install -g vscode-langservers-extracted
		vim.lsp.enable({
			"lua_ls",
			"eslint",
			"jsonls",
			"cssls",
			"html",
			"yamlls",
			"tsc",
			"tailwindcss",
			"marksman",
		})

		config("tsc", {
			on_attach = on_attach,
			-- Required by ts-expand-hover.nvim to expand types
			capabilities = { experimental = { hoverVerbosityLevel = true } },
			settings = require("plugins.lsp.settings.tsc").settings,
		})

		config("lua_ls", {
			on_attach = on_attach,
			settings = require("plugins.lsp.settings.lua_ls").settings,
		})

		config("eslint", {
			settings = require("plugins.lsp.settings.eslint").settings,
		})

		config("jsonls", {
			on_attach = on_attach,
			init_options = { provideFormatter = false },
		})

		config("cssls", {
			on_attach = on_attach,
		})

		config("html", {
			on_attach = on_attach,
			init_options = { provideFormatter = false },
		})

		config("marksman", {
			on_attach = on_attach,
		})

		require("plugins.lsp.progress").setup()
	end,
}
