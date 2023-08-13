return {
	"tzachar/highlight-undo.nvim",
	keys = {
		{
			"u",
		},
		{
			"U",
		},
	},
	opts = {
		duration = 300,
		undo = {
			hlgroup = "HighlightUndo",
			mode = "n",
			lhs = "u",
			map = "undo",
		},
		redo = {
			hlgroup = "HighlightUndo",
			mode = "n",
			lhs = "U",
			map = "redo",
		},
	},
}
