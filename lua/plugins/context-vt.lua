return {
	"andersevenrud/nvim_context_vt",
	lazy = false,
	config = function()
		require("nvim_context_vt").setup({
			prefix = "~~~>",
			-- How many lines required after starting position to show virtual text
			-- Default: 1 (equals two lines total)
			min_rows = 2,
		})
	end,
}
