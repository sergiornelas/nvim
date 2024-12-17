return {
	"andersevenrud/nvim_context_vt",
	event = "BufReadPost",
	config = function()
		require("nvim_context_vt").setup({
			prefix = " ->",
			min_rows = 8,
		})
	end,
}
