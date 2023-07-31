return {
	"anuvyklack/windows.nvim",
	dependencies = {
		"anuvyklack/middleclass",
		"anuvyklack/animation.nvim",
	},
	event = "WinNew",
	opts = {
		autowidth = {
			winwidth = 25,
		},
		ignore = {
			buftype = { "quickfix" },
			filetype = { "NvimTree", "neo-tree", "undotree", "gundo", "DiffviewFiles" },
		},
		animation = {
			enable = true,
			-- duration = 300,
			-- fps = 30,
			duration = 42,
			fps = 120,
			easing = "in_out_sine",
		},
	},
}
