return {
	"tzachar/highlight-undo.nvim",
	keys = {
		{
			"u",
		},
		{
			"<c-r>",
		},
	},
	opts = {
		duration = 300,
		undo = {
			hlgroup = "HighlightUndo",
			mode = "n",
			lhs = "u",
			map = "undo",
			opts = {},
		},
		redo = {
			hlgroup = "HighlightUndo",
			mode = "n",
			lhs = "<C-r>",
			map = "redo",
			opts = {},
		},
		highlight_for_count = true,
	},
}
