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
				"json", -- using LSP jsonls
			},
		}),
		diagnostics.eslint_d,
	},
})
