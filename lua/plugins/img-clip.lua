return {
	-- brew install pngpaste
	"HakonHarnes/img-clip.nvim",
	cond = not vim.g.vscode,
	-- press yi to copy an image from the clipboard (vimium C)
	keys = {
		{ "<leader>P", "o<esc>k<cmd>PasteImage<cr>" },
	},
	opts = {
		default = {
			dir_path = function()
				return vim.fn.expand("~") .. "/notes/images-storage/"
			end,
		},
	},
}
