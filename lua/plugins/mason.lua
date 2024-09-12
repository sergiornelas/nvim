return {
	"williamboman/mason.nvim",
	ft = { "lua", "html", "css", "json", "javascript", "javascriptreact", "typescript", "typescriptreact", "markdown" },
	config = function()
		local mason_ok, mason = pcall(require, "mason")

		if not mason_ok then
			return
		end

		-- list of servers I need:
		-- "cssls",
		-- "eslint",
		-- "html",
		-- "jsonls",
		-- "lua_ls",
		-- "ts_ls",

		mason.setup()
	end,
}
