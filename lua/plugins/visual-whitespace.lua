return {
	"mcauley-penney/visual-whitespace.nvim",
	config = true,
	event = "ModeChanged *:[vV\22]",
	cond = not vim.g.vscode,
}
