return {
	"SmiteshP/nvim-navbuddy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<leader>n", "<cmd>Navbuddy<cr>", desc = "Navbuddy" },
	},
	config = function()
		local navbuddy_ok, navbuddy = pcall(require, "nvim-navbuddy")
		if not navbuddy_ok then
			return
		end

		local actions = require("nvim-navbuddy.actions")
		navbuddy.setup({
			window = {
				size = { height = "35%", width = "65%" },
				position = "75%",
				sections = {
					left = {
						size = "30%",
					},
					mid = {
						size = "40%",
					},
					right = {
						size = "30%",
					},
				},
			},
			node_markers = {
				enabled = true,
				icons = {
					leaf = "  ",
					leaf_selected = " → ",
					branch = " ",
				},
			},
			use_default_mappings = false,
			mappings = {
				["<esc>"] = actions.close,
				["j"] = actions.next_sibling,
				["k"] = actions.previous_sibling,
				["h"] = actions.parent,
				["l"] = actions.children,
				["0"] = actions.root,
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
				["o"] = actions.select,
				["J"] = actions.move_down,
				["K"] = actions.move_up,
				["t"] = actions.telescope({
					layout_config = {
						height = 0.60,
						width = 0.60,
						prompt_position = "top",
						preview_width = 0.50,
					},
					layout_strategy = "horizontal",
				}),
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
