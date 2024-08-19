return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = "BufReadPost",
	---@module "ibl"
	opts = {
		indent = { highlight = "IndentLine", char = "│" },
		scope = {
			enabled = false,
		},
	},
}
