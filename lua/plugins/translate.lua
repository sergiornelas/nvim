return {
	"uga-rosa/translate.nvim",
	keys = {
		{
			"<leader>\\e",
			"<cmd>:Translate en -output=replace<cr>",
			mode = { "n", "x" },
		},
		{
			"<leader>\\s",
			"<cmd>Translate es -output=replace<cr>",
			mode = { "n", "x" },
		},
	},
}
