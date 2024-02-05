return {
	"stevearc/oil.nvim",
	keys = {
		{ "<leader>j", "<cmd>Oil<cr>" },
	},
	opts = {
		keymaps = {
			["g?"] = "actions.show_help",
			["gd"] = "actions.select",
			["<c-s>"] = "actions.select_vsplit",
			["<c-h>"] = "actions.select_split",
			["<c-t>"] = "actions.select_tab",
			["<c-p>"] = "actions.preview",
			["<c-c>"] = "actions.close",
			["<c-l>"] = "actions.refresh",
			["<c-k>"] = "actions.parent",
			["_"] = "actions.open_cwd",
			["`"] = "actions.cd",
			["~"] = "actions.tcd",
			["gs"] = "actions.change_sort",
			["gx"] = "actions.open_external",
			["g."] = "actions.toggle_hidden",
			["g\\"] = "actions.toggle_trash",
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
