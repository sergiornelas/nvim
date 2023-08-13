return {
	"chrisgrieser/nvim-early-retirement",
	config = function()
		require("early-retirement").setup({
			retirementAgeMins = 1440,
		})
	end,
	event = "VeryLazy",
}
