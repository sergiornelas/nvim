return {
	"folke/twilight.nvim",
	ft = "norg",
	config = function()
		require("twilight").setup({
			dimming = {
				alpha = 0.25,
			},
			context = 10, -- amount of lines we will try to show around the current line
			expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
				"function",
				"method",
				"table",
				"if_statement",
				"heading3", --norg
			},
			exclude = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"markdown",
			},
		})
	end,
}
