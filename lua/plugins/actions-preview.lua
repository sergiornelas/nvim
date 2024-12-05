return {
	"aznhe21/actions-preview.nvim",
	keys = {
		{
			"gl",
			"<cmd>lua require('actions-preview').code_actions()<cr>",
			mode = { "n", "v" },
		},
	},
	config = function()
		local hl = require("actions-preview.highlight")
		require("actions-preview").setup({
			highlight_command = {
				hl.delta(
					"delta --no-gitconfig --hunk-header-style raw --hunk-header-decoration-style none --file-style omit"
				),
			},
			telescope = {
				sorting_strategy = "ascending",
				layout_strategy = "vertical",
				layout_config = {
					width = 0.6,
					height = 0.6,
					prompt_position = "top",
					preview_cutoff = 10,
					preview_height = function(_, _, max_lines)
						return max_lines - 14
					end,
				},
			},
		})
	end,
	-- alternative: rachartier/tiny-code-action.nvim
	-- but doesn't allow me to personalize delta args
}
