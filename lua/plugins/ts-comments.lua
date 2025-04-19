return {
	"folke/ts-comments.nvim",
	cond = not vim.g.vscode,
	opts = {},
	event = "VeryLazy",
	enabled = vim.fn.has("nvim-0.10.0") == 1,
}
