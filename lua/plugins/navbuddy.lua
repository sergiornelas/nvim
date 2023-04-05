return {
	"SmiteshP/nvim-navbuddy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	cmd = "Navbuddy",
	config = function()
		local navbuddy_ok, navbuddy = pcall(require, "nvim-navbuddy")
		if not navbuddy_ok then
			return
		end

		local actions = require("nvim-navbuddy.actions")
		navbuddy.setup({
			window = {
				size = "45%",
				position = "75%",
				sections = {
					mid = {
						size = "50%",
					},
					right = {
						size = "30%",
					},
				},
			},
			mappings = {
				["<esc>"] = actions.close,
				["<c-i>"] = actions.next_sibling,
				["<c-o>"] = actions.previous_sibling,
				["<c-a>"] = actions.parent,
				["<c-f>"] = actions.children,
				["v"] = actions.visual_name,
				["V"] = actions.visual_scope,
				["q"] = actions.yank_name,
				["Q"] = actions.yank_scope,
				["i"] = actions.insert_name,
				["I"] = actions.insert_scope,
				["a"] = actions.append_name,
				["A"] = actions.append_scope,
				["r"] = actions.rename,
				["D"] = actions.delete,
				["f"] = actions.fold_create,
				["F"] = actions.fold_delete,
				["C"] = actions.comment,
				["<c-j>"] = actions.select,
				["J"] = actions.move_down,
				["K"] = actions.move_up,
			},
			lsp = {
				auto_attach = false, -- If set to true, you don't need to manually use attach function
				preference = nil, -- list of lsp server names in order of preference
			},
			source_buffer = {
				follow_node = true, -- Keep the current node in focus on the source buffer
				highlight = true, -- Highlight the currently focused node
				reorient = "smart", -- "smart", "top", "mid" or "none"
				scrolloff = nil, -- scrolloff value when navbuddy is open
			},
		})
	end,
}
