return {
	"williamboman/mason.nvim",
	ft = { "lua", "html", "css", "json", "javascript", "javascriptreact", "typescript", "typescriptreact", "markdown" },
	cond = not vim.g.vscode,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local mason_ok, mason = pcall(require, "mason")
		local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")

		if not mason_ok or not mason_lspconfig_ok then
			return
		end

		local servers = {
			"cssls",
			"eslint",
			"html",
			"jsonls",
			"lua_ls",
			-- "ts_ls",
		}

		mason.setup()

		-- This plugin uses the lspconfig server names in the APIs it exposes,
		-- not mason.nvim package names (prettierd, stylua, markdownlint).
		-- You have to install them manually with MasonInstall.
		mason_lspconfig.setup({
			ensure_installed = servers,
			automatic_installation = true,
		})
	end,
}
