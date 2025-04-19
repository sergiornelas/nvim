return {
	"rachartier/tiny-glimmer.nvim",
	event = "VeryLazy",
	cond = not vim.g.vscode,
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
		-- Only use if you have a transparent background
		-- It will override the highlight group background color for `to_color` in all animations
		transparency_color = "#2d2c2b",
		animations = {
			hijack_ft_disabled = {
				"alpha",
				"snacks_dashboard",
			},
		},
	},
}
