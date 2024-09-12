return {
	"aznhe21/actions-preview.nvim",
	keys = {
		{
			"gl",
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
	-- doesn't work with pmizio/typescript-tools.nvim
	-- {
	-- 	"rachartier/tiny-code-action.nvim",
	-- 	dependencies = {
	-- 		{ "nvim-lua/plenary.nvim" },
	-- 		{ "nvim-telescope/telescope.nvim" },
	-- 	},
	-- 	keys = {
	-- 		{
	-- 			"gl",
	-- 			"<cmd>lua require('tiny-code-action').code_action()<cr>",
	-- 			mode = { "n", "v" },
	-- 		},
	-- 	},
	-- 	event = "LspAttach",
	-- 	config = function()
	-- 		require("tiny-code-action").setup()
	-- 	end,
	-- },
}
