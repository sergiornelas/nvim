return {
	"mcauley-penney/visual-whitespace.nvim",
	cond = not vim.g.vscode,
	event = "ModeChanged *:[vV\22]",
	config = true,
}
