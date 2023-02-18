return {
	{
		"ggandor/leap.nvim",
		keys = { { "s", mode = { "n", "x" } }, { "S", mode = { "n", "x" } } },
		config = function()
			require("leap").add_default_mappings()
		end,
	},
	{
		"anuvyklack/windows.nvim",
		dependencies = "anuvyklack/middleclass",
		event = "WinNew",
		config = true,
	},
	{
		"xorid/swap-split.nvim",
		cmd = "SwapSplit",
		config = true,
	},
	{
		"xiyaowong/nvim-transparent",
		lazy = false,
		opts = {
			enable = true,
		},
	},
	{ "famiu/bufdelete.nvim", cmd = "Bdelete" },
	{
		"rhysd/clever-f.vim",
		keys = {
			{
				"f",
				mode = { "n", "x" },
			},
			{
				"F",
				mode = { "n", "x" },
			},
			{
				"t",
				mode = { "n", "x" },
			},
			{
				"T",
				mode = { "n", "x" },
			},
		},
	},
	{
		"kwkarlwang/bufjump.nvim",
		-- keys = {
		--  "K",
		--  "J",
		-- },
		config = function()
			require("bufjump").setup({
				-- 	forward = "K",
				-- 	backward = "J",
			})
		end,
	},
}
