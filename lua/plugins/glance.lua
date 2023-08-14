return {
	"DNLHC/glance.nvim",
	cmd = "Glance",
	config = function()
		local glance = require("glance")
		local actions = glance.actions
		require("glance").setup({
			height = 25,
			preview_win_opts = { -- Configure preview window options
				number = false,
				wrap = false,
			},
			mappings = {
				list = {
					["l"] = actions.jump,
					["<c-j>"] = actions.jump,
					["<c-i>"] = actions.next,
					["<c-o>"] = actions.previous,
					["<c-l>"] = actions.jump,
					["<c-v>"] = actions.jump_vsplit,
					["<c-s>"] = actions.jump_split,
					["<c-r>"] = actions.jump_tab,
				},
			},
		})
	end,
}
