return {
	"DNLHC/glance.nvim",
	cmd = "Glance",
	config = function()
		local glance = require("glance")
		local actions = glance.actions
		require("glance").setup({
			height = 25,
			mappings = {
				list = {
					["<c-i>"] = actions.next,
					["<c-o>"] = actions.previous,
					["l"] = actions.jump,
					["<c-l>"] = actions.jump,
					["<c-v>"] = actions.jump_vsplit,
					["<c-s>"] = actions.jump_split,
					["<c-t>"] = actions.jump_tab,
				},
			},
		})
	end,
}
