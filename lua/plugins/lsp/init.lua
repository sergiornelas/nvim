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
		{
			"zeioth/garbage-day.nvim",
			dependencies = "neovim/nvim-lspconfig",
			opts = {
				aggressive_mode = true,
				excluded_lsp_clients = {
					"typescript-tools",
					"eslint",
				},
				-- grace_period = 60*15, -- is ignored by aggresive_mode
				aggresive_mode_ignore = {
					filetype = { "", "markdown", "text", "oil", "snacks_picker_input" },
					buftype = { "nofile" },
				},
				notifications = false,
			},
		},
	},
	config = function()
		local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
		if not lspconfig_ok then
			return
		end

		require("plugins.lsp.diagnostics").setup()
		local on_attach = require("plugins.lsp.handlers").on_attach
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- npm init @eslint/config@latest
		-- some code actions doesn't show in the preview
		-- lspconfig.ts_ls.setup({
		-- 	server = {
		-- 		on_attach = on_attach,
		-- 		capabilities = capabilities,
		-- 		settings = require("plugins.lsp.settings.tsserver").settings,
		-- 	},
		-- })

		lspconfig.eslint.setup({
			settings = require("plugins.lsp.settings.eslint").settings,
			capabilities = capabilities,
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
	end,
}
