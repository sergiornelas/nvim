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
}
