return {
	"mason-org/mason.nvim",
	ft = { "lua", "html", "css", "json", "javascript", "javascriptreact", "typescript", "typescriptreact", "markdown" },
	config = function()
		local mason_ok, mason = pcall(require, "mason")

		if not mason_ok then
			return
		end

		-- local servers = {
		-- 	"cssls",
		-- 	"eslint",
		-- 	"html",
		-- 	"jsonls",
		-- 	"lua_ls",
		-- 	-- "ts_ls",
		-- }

		mason.setup()

		-- This plugin uses the lspconfig server names in the APIs it exposes,
		-- not mason.nvim package names (prettierd, stylua, markdownlint).
		-- You have to install them manually with MasonInstall.
		-- mason_lspconfig.setup({
		-- 	ensure_installed = servers,
		-- })
	end,
}
