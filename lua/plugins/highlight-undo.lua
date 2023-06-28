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
		hlgroup = "HighlightUndo",
		duration = 300,
		keymaps = {
			{ "n", "u", "undo", {} },
			{ "n", "U", "redo", {} },
		},
	},
}
