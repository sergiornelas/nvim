return {
	{
		"ggandor/leap.nvim",
		keys = {
			{
				"s",
				"<cmd> lua require('leap').leap({ target_windows = { vim.fn.win_getid() } })<cr>",
				mode = { "n", "x" },
			},
		},
	},
	{
		"gcmt/taboo.vim",
		lazy = false,
		config = function()
			vim.g.taboo_renamed_tab_format = "   [%l] %m "
			vim.g.taboo_tab_format = "   %f %m "
			vim.g.taboo_modified_tab_flag = " "
		end,
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
		"chrisgrieser/nvim-early-retirement",
		config = true,
		event = "VeryLazy",
	},
}
