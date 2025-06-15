return {
	-- brew install deno
	"kbwo/vim-shareedit",
	cmd = "ShareEditStart",
	cond = not vim.g.vscode,
	dependencies = {
		"vim-denops/denops.vim",
	},
}
