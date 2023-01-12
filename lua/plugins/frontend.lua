return {
	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
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
				"<leader>vz",
				"<cmd>lua require('zippy').insert_print()<cr>",
			},
		},
	},
	{
		"Oldenborg/vim-px-to-rem",
		keys = {
			{
				"<leader>vp",
				"<cmd>Px!<cr>",
			},
			{
				"<leader>vr",
				"<cmd>Rem!<cr>",
			},
		},
	},
}
