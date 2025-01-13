return {
	"stevearc/oil.nvim",
	keys = {
		{ "<c-c>", "<cmd>Oil --float<cr>" },
	},
	dependencies = {
		"echasnovski/mini.icons",
		opts = {},
		-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/ui.lua#L287
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
	config = function()
		local oil = require("oil")

		oil.setup({
			keymaps = {
				["g?"] = { "actions.show_help", mode = "n" },
				["<c-j>"] = "actions.select",
				["<c-s>"] = { "actions.select", opts = { vertical = true } },
				["<c-h>"] = { "actions.select", opts = { horizontal = true } },
				["<c-t>"] = { "actions.select", opts = { tab = true } },
				["<c-c>"] = { "actions.close", mode = "n" },
				["<c-k>"] = { "actions.parent", mode = "n" },
				["<c-g>"] = { "actions.open_cwd", mode = "n" },
				["<c-;>"] = { "actions.cd", mode = "n" },
				["<c-'>"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
				["gs"] = { "actions.change_sort", mode = "n" },
				["gx"] = "actions.open_external",
				["g."] = { "actions.toggle_hidden", mode = "n" },
				["g\\"] = { "actions.toggle_trash", mode = "n" },
				["gy"] = {
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
				["gd"] = {
					callback = function()
						---@diagnostic disable-next-line: lowercase-global
						detail = not detail
						if detail then
							require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
						else
							require("oil").set_columns({ "icon" })
						end
					end,
				},
				["<leader>P"] = function()
					local filename = oil.get_cursor_entry().name
					local dir = oil.get_current_dir()
					oil.close()

					local img_clip = require("img-clip")
					img_clip.paste_image({}, dir .. filename)
				end,
			},
			-- Configuration for the floating window in oil.open_float
			float = {
				padding = 6,
				max_width = 80,
				max_height = 0,
				border = "single",
				preview_split = "above",
				-- win_options = {
				-- 	winblend = 0, -- bug, only works with initial dir
				-- },
			},
			progress = {
				border = "single",
			},
			ssh = {
				border = "single",
			},
			keymaps_help = {
				border = "single",
			},
		})
	end,
}
