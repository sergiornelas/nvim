return {
	"mcauley-penney/visual-whitespace.nvim",
	event = "ModeChanged *:[vV\x16]",
	cond = not vim.g.vscode,
	config = true,
}
