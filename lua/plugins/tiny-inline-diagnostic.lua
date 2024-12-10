return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy",
	config = function()
		require("tiny-inline-diagnostic").setup({
			options = {
				show_source = false,
				-- Enable diagnostic message on all lines.
				multilines = true,
				virt_texts = {
					priority = 4500,
				},
			},
			signs = {
				arrow = "    ",
				up_arrow = "    ",
			},
		})
	end,
}
