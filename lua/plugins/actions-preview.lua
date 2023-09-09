return {
	"aznhe21/actions-preview.nvim",
	lazy = false,
	opts = {
		telescope = {
			sorting_strategy = "ascending",
			layout_strategy = "vertical",
			layout_config = {
				width = 0.5,
				height = 0.5,
				prompt_position = "top",
				preview_cutoff = 10,
				preview_height = function(_, _, max_lines)
					return max_lines - 12
				end,
			},
		},
	},
}
