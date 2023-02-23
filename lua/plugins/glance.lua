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
					["<c-c>v"] = actions.jump_vsplit,
					["<c-c>s"] = actions.jump_split,
					["<c-c>t"] = actions.jump_tab,
				},
			},
		})
	end,
}
