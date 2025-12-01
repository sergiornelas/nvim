return {
	"rachartier/tiny-glimmer.nvim",
	event = "VeryLazy",
	opts = {
		enabled = true,
		overwrite = {
			yank = {
				enabled = true,
				default_animation = "fade",
			},
			search = {
				enabled = true,
				default_animation = "fade",
				next_mapping = "n",
				prev_mapping = "N",
			},
			paste = {
				enabled = true,
				default_animation = "reverse_fade",
				paste_mapping = "p",
				Paste_mapping = "P",
			},
			undo = {
				enabled = true,
				default_animation = {
					name = "fade",
					settings = {
						from_color = "#722529",
						max_duration = 500,
						min_duration = 500,
					},
				},
				undo_mapping = "u",
			},
			redo = {
				enabled = true,
				default_animation = {
					name = "fade",
					settings = {
						from_color = "#62693e",
						max_duration = 500,
						min_duration = 500,
					},
				},
				redo_mapping = "<c-r>",
			},
		},
		-- Override background color for animations (for transparent backgrounds)
		transparency_color = "#2d2c2b",
		hijack_ft_disabled = {
			"alpha",
			"snacks_dashboard",
		},
	},
}
