local M = {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		{
			"pmizio/typescript-tools.nvim",
		},
		{
			"ray-x/lsp_signature.nvim",
			config = true,
		},
		{
			"kosayoda/nvim-lightbulb",
			opts = {
				autocmd = { enabled = true, updatetime = 100 },
			},
		},
	},
}

function M.config()
	local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
	local typescript_tools_ok, typescript_tools = pcall(require, "typescript-tools")

	if not lspconfig_ok or not typescript_tools_ok then
		return
	end

	require("plugins.lsp.diagnostics").setup()
	local on_attach = require("plugins.lsp.handlers").on_attach
	local capabilities = require("plugins.lsp.handlers").capabilities

	typescript_tools.setup({
		on_attach = on_attach,
		settings = {
			-- spawn additional tsserver instance to calculate diagnostics on it
			separate_diagnostic_server = true,
			publish_diagnostic_on = "insert_leave", -- "change"|"insert_leave"
			-- expose_as_code_action = { "fix_all", "add_missing_imports", "remove_unused" },
			expose_as_code_action = {},
			-- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
			-- not exists then standard path resolution strategy is applied
			tsserver_path = nil,
			-- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
			tsserver_plugins = {
				-- for TypeScript v4.9+
				"@styled/typescript-styled-plugin",
				-- or for older TypeScript versions
				-- "typescript-styled-plugin",
			},
			tsserver_format_options = {},
			tsserver_file_preferences = require("plugins.lsp.settings.tsserver"),
			complete_function_calls = true, -- param alias sugestion
		},
		-- handlers = {
		-- 	["textDocument/publishDiagnostics"] = require("typescript-tools.api").filter_diagnostics({ 80006 }),
		-- },
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
