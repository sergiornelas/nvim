return {
	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter",
		ft = { "javascriptreact", "typescriptreact" },
	},
	{
		"uga-rosa/ccc.nvim",
		config = true,
		cmd = "CccPick",
	},
	{
		"PatschD/zippy.nvim",
		keys = {
			{
				"<leader>z",
				"<cmd>lua require('zippy').insert_print()<cr>",
			},
		},
	},
}
