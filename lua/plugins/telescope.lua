-- I still need telescope for:
-- 1) aznhe21/actions-preview.nvim
-- 2) rmagatti/auto-session
-- 3) spell_suggest command
-- 4) colorscheme command
-- 5) Paste_image()

return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	build = "make",
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")

		function Paste_image()
			builtin.find_files({
				attach_mappings = function(_, map)
					local function embed_image(prompt_bufnr)
						local entry = require("telescope.actions.state").get_selected_entry()
						local filepath = entry[1]
						actions.close(prompt_bufnr)
						local img_clip = require("img-clip")
						img_clip.paste_image(nil, filepath)
					end
					map("i", "<c-j>", embed_image)
					map("n", "<c-j>", embed_image)
					return true
				end,
			})
		end

		telescope.setup({
			defaults = {
				layout_strategy = "vertical", --horizontal/vertical/flex
				sorting_strategy = "ascending", --important
				winblend = 6,
				results_title = "",
				layout_config = {
					vertical = {
						width = 90,
						height = 60,
					},
				},
				prompt_prefix = "  ",
				selection_caret = "  ",
				path_display = { "smart" },
				mappings = {
					i = {
						["<c-i>"] = actions.move_selection_next,
						["<c-o>"] = actions.move_selection_previous,
						["<c-j>"] = actions.select_default,
						["<c-m>"] = actions.cycle_history_next,
						["<c-;>"] = actions.cycle_history_prev,
						["<c-z>"] = actions.to_fuzzy_refine,
						["<esc>"] = actions.close,
						["<c-space>"] = actions.close,
						["<c-n>"] = actions.toggle_selection + actions.move_selection_worse,
						["<c-p>"] = actions.toggle_selection + actions.move_selection_better,
						["<c-b>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
				file_ignore_patterns = {
					"%.sc",
					"%.mp3",
					"%.wav",
					"%.oga",
					"%.ogg",
					-- https://www.squash.io/how-to-git-ignore-node-modules-folder-everywhere/
					-- "node_modules/.*",
				},
			},
			pickers = {
				colorscheme = {
					enable_preview = true,
					ignore_builtins = true,
				},
			},
		})
	end,
	keys = {
		{ "<leader>f;", "<cmd>Telescope resume<cr>" },
		-- Vim pickers
		{ "<leader>fQ", "<cmd>Telescope quickfixhistory<cr>" },
		{ "<leader>fv", "<cmd>Telescope vim_options<cr>" },
		{ "<leader>fp", "<cmd>Telescope spell_suggest theme=cursor layout_config={height=15}<cr>" },
		-- Git Pickers
		{ "<leader>gM", "<cmd>Telescope git_bcommits_range<cr>" },
		{ "<leader>gr", "<cmd>Telescope git_branches<cr>" },
		-- Plugins
		{ "<leader>fP", "<cmd>lua Paste_image()<cr>" },
		{ "<c-space>", "<cmd>Telescope session-lens<cr>" },
	},
}
