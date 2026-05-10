return {
	"cajames/copy-reference.nvim",
	opts = {},
	keys = {
		{ "<leader>y", "<cmd>CopyReference file<cr>", mode = { "n", "v" } },
		{ "<leader>Y", "<cmd>CopyReference line<cr>", mode = { "n", "v" } },
	},
}
