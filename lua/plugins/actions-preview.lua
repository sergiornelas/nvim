return {
	"aznhe21/actions-preview.nvim",
	keys = {
		{
			"<leader>a",
			"<cmd>lua require('actions-preview').code_actions()<cr>",
			mode = { "n", "v" },
		},
	},
	opts = {
		telescope = {
			sorting_strategy = "ascending",
			layout_strategy = "vertical",
			layout_config = {
				width = 0.6,
				height = 0.6,
				prompt_position = "top",
				preview_cutoff = 10,
				preview_height = function(_, _, max_lines)
					return max_lines - 12
				end,
			},
		},
	},
}
