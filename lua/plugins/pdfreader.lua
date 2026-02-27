-- brew install ghostscript
-- brew install poppler
return {
	"r-pletnev/pdfreader.nvim",
	ft = "yaml",
	dependencies = {
		"folke/snacks.nvim",
	},
	config = function()
		require("pdfreader").setup()
	end,
}
