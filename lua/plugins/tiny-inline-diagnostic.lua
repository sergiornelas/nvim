return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "LspAttach",
	config = function()
		require("tiny-inline-diagnostic").setup({
			preset = "powerline",
			options = {
				show_source = false,
				-- Enable diagnostic message on all lines.
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
