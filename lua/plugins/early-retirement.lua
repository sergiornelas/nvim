return {
	"chrisgrieser/nvim-early-retirement",
	config = function()
		require("early-retirement").setup({
			retirementAgeMins = 120,
		})
	end,
	event = "VeryLazy",
}
