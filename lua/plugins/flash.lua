return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		labels = "jiofewasdghklqrtyupzxcvbnm",
		label = {
			uppercase = false,
		},
		modes = {
			search = {
				enabled = false,
			},
			char = {
				keys = { "f", "F", "t", "T", [";"] = "_", [","] = "!" },
				search = { wrap = true },
			},
		},
	},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
		},
		{
			"S",
			mode = { "n", "o", "x" },
			function()
				require("flash").treesitter()
			end,
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
		},
		{
			"<c-s>",
			mode = { "c" },
			function()
				require("flash").toggle()
			end,
		},
	},
}
