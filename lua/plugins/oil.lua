return {
	"stevearc/oil.nvim",
	keys = {
		{ "<c-space>", "<cmd>Oil --float<cr>" },
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local oil = require("oil")
		oil.setup({
			keymaps = {
				["g?"] = "actions.show_help",
				["<c-j>"] = "actions.select",
				["<c-s>"] = "actions.select_vsplit",
				["<c-h>"] = "actions.select_split",
				["<c-space>"] = "actions.close",
				["<c-k>"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
				["yp"] = {
					callback = function()
						local entry = oil.get_cursor_entry()
						local dir = oil.get_current_dir()
						if not entry or not dir then
							return
						end
						local relpath = vim.fn.fnamemodify(dir, ":.")
						vim.fn.setreg("+", relpath .. entry.name)
					end,
				},
			},
			-- Configuration for the floating window in oil.open_float
			float = {
				padding = 6,
				max_width = 80,
				max_height = 0,
				border = "single",
				-- win_options = {
				-- 	winblend = 0, -- bug, only works with initial dir
				-- },
			},
			preview = {
				border = "single",
			},
			progress = {
				border = "single",
			},
			keymaps_help = {
				border = "single",
			},
		})
	end,
}