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
				"<leader>z",
				"<cmd>lua require('zippy').insert_print()<cr>",
			},
		},
	},
	{
		"Oldenborg/vim-px-to-rem",
		keys = {
			{
				"<leader>P",
				"<cmd>Px!<cr>",
			},
			{
				"<leader>R",
				"<cmd>Rem!<cr>",
			},
		},
	},
}
