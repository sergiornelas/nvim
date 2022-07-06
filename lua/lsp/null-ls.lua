--=================={Installers}=========================
--  > npm install -g eslint_d
--  > npm install -g @fsouza/prettierd
--  > brew install stylua
--  > brew install tidy-html5

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
		formatting.prettierd,
		formatting.fish_indent,
		diagnostics.eslint_d,
		diagnostics.fish,
	},
})
