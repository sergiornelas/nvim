return {
	"chrisgrieser/nvim-early-retirement",
	config = function()
		require("early-retirement").setup({
			retirementAgeMins = 60,
		})
	end,
	event = "VeryLazy",
}
