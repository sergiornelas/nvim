return {
	-- brew install nikolaeu/numi/numi-cli
	"josephburgess/nvumi",
	dependencies = { "folke/snacks.nvim" },
	keys = {
		{
			"<leader>v",
			"<cmd>Nvumi<cr>",
		},
	},
	opts = {
		virtual_text = "inline", -- or "newline"
		keys = {
			run = "<c-j>",
			reset = "<c-c><c-c>",
		},
	},
}
