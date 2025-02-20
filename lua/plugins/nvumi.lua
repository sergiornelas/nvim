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
		virtual_text = "inline", -- "newline"
		prefix = "= ",
		date_format = "uk", -- uk, us, long
		keys = {
			run = "<c-j>",
			reset = "<c-c><c-c>",
			yank = "<leader>y", -- yank output of current line
			yank_all = "<leader>Y", -- yank all outputs
		},
	},
}
