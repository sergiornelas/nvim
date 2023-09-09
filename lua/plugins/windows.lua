return {
	"anuvyklack/windows.nvim",
	dependencies = {
		"anuvyklack/middleclass",
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
			enable = false,
		},
	},
}
