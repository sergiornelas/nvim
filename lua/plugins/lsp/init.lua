local M = {
	"neovim/nvim-lspconfig",
	ft = { "lua", "html", "css", "json", "javascript", "javascriptreact", "typescript", "typescriptreact" },
	dependencies = {
		{
			"lvimuser/lsp-inlayhints.nvim",
			config = true,
		},
		{
			"ray-x/lsp_signature.nvim",
			config = true,
		},
		{
			"kosayoda/nvim-lightbulb",
			dependencies = "antoinemadec/FixCursorHold.nvim",
			config = function()
				vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
				vim.fn.sign_define("LightBulbSign", { text = "󰯙" })
			end,
		},
	},
}

function M.config()
	local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
	local typescript_ok, typescript = pcall(require, "typescript")

	if not lspconfig_ok or not typescript_ok then
		return
	end

	require("plugins.lsp.diagnostics").setup()
	local on_attach = require("plugins.lsp.handlers").on_attach
	local capabilities = require("plugins.lsp.handlers").capabilities

	typescript.setup({
		server = {
			on_attach = on_attach,
			capabilities = capabilities,
			settings = require("plugins.lsp.settings.tsserver").settings,
			-- root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "node_modules"),
		},
	})

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
