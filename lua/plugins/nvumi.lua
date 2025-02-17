return {
	-- brew install nikolaeu/numi/numi-cli
	"josephburgess/nvumi",
	keys = {
		{
			"<leader>u",
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
	dependencies = { "folke/snacks.nvim" },
}
