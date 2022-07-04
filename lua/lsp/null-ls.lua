--=================={Installers}=========================
--  > npm install -g typescript typescript-language-server
--  > npm install -g eslint_d
--  > npm install -g @fsouza/prettierd
--  > brew install tidy-html5
--  > brew install stylua

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		formatting.stylua,
		formatting.prettierd.with({
			disabled_filetypes = {
				-- using LSP jsonls
				"json",
			},
		}),
		diagnostics.eslint_d,
		-- diagnostics.jsonlint, --json
		-- LSP status===============
		--  JS, JSX, TS, TSX completions: tsserver*
		--  TS, TSX diagnostics: tsserver*, BUT LOOKS LIKE JS FILES ALSO APPLIES
		--  HTML completions: html (formatting turned off for prettier)
		--  CSS completions: cssls
		--  CSS diagnostics: cssls
		--  Lua diagnostics: sumneko_lua (also has a weak formatting)

		-- diagnostics.eslint_d.with({
		-- 	filetypes = { "javascript" },
		-- }),
		-- code_actions.eslint_d.with({
		-- 	filetypes = { "javascript" },
		-- }),
	},
	on_attach = require("lsp.handlers").on_attach,
	-- capabilities = require("lsp.handlers").capabilities,
})
