return {
	"Wansmer/sibling-swap.nvim",
	dependencies = { "nvim-treesitter" },
	opts = {
		keymaps = {
			["<C-.>"] = "swap_with_right",
			["<C-,>"] = "swap_with_left",
			["<space>."] = "swap_with_right_with_opp",
			["<space>,"] = "swap_with_left_with_opp",
		},
	},
	keys = {
		"<c-,>",
		"<c-.>",
		"<leader>.",
		"<leader>,",
	},
}
