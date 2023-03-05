return {
	{
		"ggandor/leap.nvim",
		keys = {
			{
				"s",
				"<cmd> lua require('leap').leap({ target_windows = { vim.fn.win_getid() } })<cr>",
			},
		},
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
		keys = {
			"K",
			"J",
		},
		config = function()
			require("bufjump").setup({
				forward = "K",
				backward = "J",
			})
		end,
	},
}
