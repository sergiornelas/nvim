local M = {
	"neovim/nvim-lspconfig",
	lazy = false,
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
		--  wait for mature (bugs):
		-- {
		-- 	"ray-x/lsp_signature.nvim",
		-- 	opts = {
		-- 		transparency = 23,
		-- 	},
		-- 	commit = "c9dc249794e472a8dd7f87c80f9dcbdba4c68ce1",
		-- 	keys = {
		-- 		{
		-- 			"<c-g><c-s>",
		-- 			function()
		-- 				require("lsp_signature").toggle_float_win()
		-- 			end,
		-- 			mode = "i",
		-- 		},
		-- 	},
		-- },
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
