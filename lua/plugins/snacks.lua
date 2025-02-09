local layout = {
	layout = {
		backdrop = false,
		row = 1,
		width = 0.4,
		min_width = 85,
		height = 0.9,
		border = "none",
		box = "vertical",
		{ win = "preview", title = "{preview}", height = 0.6, border = "single" },
		{
			box = "vertical",
			border = "single",
			title = "{title} {live} {flags}",
			title_pos = "center",
			{ win = "input", height = 1, border = "bottom" },
			{ win = "list", border = "none" },
		},
	},
}

local buffers_layout = vim.deepcopy(layout)
buffers_layout.layout.height = 0.62
buffers_layout.layout.width = 0.2

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		local snacks = require("snacks")
		snacks.setup({
			styles = {
				input = {
					width = 35,
					border = "single",
					relative = "cursor",
					bo = {
						buftype = "", -- bug i_ctrl_w
					},
					keys = {
						i_esc = { "<esc>", { "cancel" }, mode = "i", expr = true },
						i_cr = { "<c-j>", { "confirm" }, mode = "i", expr = true },
						-- this is not working:
						-- i_ctrl_w = { "<c-w>", "<c-s-w>", mode = "i", expr = true },
						i_up = { "<c-p>", { "hist_up" }, mode = { "i", "n" } },
						i_down = { "<c-n>", { "hist_down" }, mode = { "i", "n" } },
					},
				},
			},
			input = {},
			indent = {
				scope = {
					enabled = false,
				},
			},
			picker = {
				formatters = {
					file = {
						filename_first = true,
					},
				},
				win = {
					input = {
						keys = {
							["<esc>"] = { "close", mode = { "n", "i" } },
							["<c-j>"] = { "confirm", mode = { "n", "i" } },
							["<c-a>"] = { "select_all", mode = { "n", "i" } },
							["<c-space>"] = { "toggle_maximize", mode = { "i", "n" } },
							["<c-c>"] = { "toggle_preview", mode = { "i", "n" } },
							["<c-y>"] = { "cycle_win", mode = { "i", "n" } },
							["<s-cr>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
							["<c-;>"] = { "history_back", mode = { "i", "n" } },
							["<c-'>"] = { "history_forward", mode = { "i", "n" } },
							["<c-n>"] = { "select_and_next", mode = { "i", "n" } },
							["<c-p>"] = { "select_and_prev", mode = { "i", "n" } },
							["<c-i>"] = { "list_down", mode = { "i", "n" } },
							["<c-o>"] = { "list_up", mode = { "i", "n" } },
							["<c-k>"] = { "preview_scroll_left", mode = { "i", "n" } },
							["<c-l>"] = { "preview_scroll_right", mode = { "i", "n" } },
							["<c-g>"] = { "toggle_live", mode = { "i", "n" } },
							["<c-t><c-i>"] = { "toggle_ignored", mode = { "i", "n" } },
							["<c-t><c-h>"] = { "toggle_hidden", mode = { "i", "n" } },
							["<c-h>"] = "",
						},
					},
					preview = {
						keys = {
							["a"] = "focus_input",
						},
					},
				},
			},
		})

		--- @param mode string|table
		--- @param key string
		--- @param command string|function
		local function map(mode, key, command)
			vim.keymap.set(mode, key, command, { noremap = true, silent = true })
		end

		-- list of layouts: default, dropdown, ivy, ivy_split, select, sidebar, telescope, vertical, vscode

		-- map("n", "<leader>", "<cmd>lua Snacks.picker.autocmds()<cr>")
		map("n", "<leader>fo", function()
			snacks.picker.buffers({
				current = false,
				layout = buffers_layout,
			})
		end)
		-- no results for cliphist:
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.cliphist()<cr>")
		-- layout select not supported yet:
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.colorschemes()<cr>")
		map("n", "<leader>:", "<cmd>lua Snacks.picker.command_history({ layout = 'vscode' })<cr>")
		map("n", "<leader>fC", "<cmd>lua Snacks.picker.commands({ layout = 'select' })<cr>")
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.diagnostics()<cr>")
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.diagnostics_buffer()<cr>")
		map("n", "<leader>o", function() -- install fd
			snacks.picker.explorer({
				auto_close = true,
				win = {
					list = {
						keys = {
							["<c-k>"] = "explorer_up",
							["<c-j>"] = "confirm",
							["p"] = "toggle_preview",
						},
					},
				},
			})
		end)
		map("n", "<leader>fi", function()
			snacks.picker.files({
				layout = layout,
				exclude = {
					"/images",
					"/sounds",
				},
			})
		end)
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.git_branches()<cr>")
		map("n", "<leader>gs", "<cmd>lua Snacks.picker.git_diff({layout = 'ivy'})<cr>")
		map("n", "<leader>gf", "<cmd>lua Snacks.picker.git_files({layout = 'ivy'})<cr>")
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.git_grep()<cr>")
		map("n", "<leader>gc", "<cmd>lua Snacks.picker.git_log()<cr>")
		-- no results found for git_log_file:
		map("n", "<leader>gm", "<cmd>lua Snacks.picker.git_log_file({layout = 'ivy_split'})<cr>")
		-- command failed:
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.git_log_line()<cr>")
		map("n", "<leader>gh", "<cmd>lua Snacks.picker.git_stash()<cr>")
		-- show other project status:
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.git_status()<cr>")
		map("n", "<leader>fl", function()
			snacks.picker.grep({
				layout = layout,
			})
		end)
		map("n", "<leader>fL", "<cmd>lua Snacks.picker.grep_buffers()<cr>")
		map({ "n", "x" }, "<leader>fw", function()
			snacks.picker.grep_word({
				layout = layout,
			})
		end)
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.help()<cr>")
		map("n", "<leader>H", "<cmd>lua Snacks.picker.highlights()<cr>")
		map("i", "<c-g><c-e>", "<cmd>lua Snacks.picker.icons({layout = 'select'})<cr>")
		map("n", "<leader>fj", "<cmd>lua Snacks.picker.jumps({layout = 'vertical'})<cr>")
		map("n", "<leader>fk", "<cmd>lua Snacks.picker.keymaps({layout = 'ivy_split'})<cr>")
		map("n", "<leader>fz", "<cmd>lua Snacks.picker.lazy({layout = 'ivy'})<cr>")
		map("n", "<leader>ff", "<cmd>lua Snacks.picker.lines({layout = 'ivy_split'})<cr>")
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.loclist()<cr>")
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.lsp_declarations()<cr>")
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.lsp_definitions()<cr>")
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.lsp_implementations()<cr>")
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.lsp_references()<cr>")
		map("n", "<leader>fy", "<cmd>lua Snacks.picker.lsp_symbols({ layout = 'sidebar' })<cr>")
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.lsp_type_definitions()<cr>")
		-- not working:
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.lsp_workspace_symbols()<cr>")
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.man()<cr>")
		map("n", "<leader>fm", "<cmd>lua Snacks.picker.marks({ layout = 'ivy' })<cr>")
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.notifications()<cr>")
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.picker_actions()<cr>")
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.picker_format()<cr>")
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.picker_layouts()<cr>")
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.picker_preview()<cr>")
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.pickers()<cr>")
		map("n", "<leader>f<leader>", "<cmd>lua Snacks.picker.projects()<cr>")
		map("n", "<leader>fq", "<cmd>lua Snacks.picker.qflist()<cr>")
		map("n", "<leader>fd", "<cmd>lua Snacks.picker.recent({ layout = 'ivy' })<cr>")
		-- not working:
		map("n", "<leader>fr", "<cmd>lua Snacks.picker.registers({layout = 'select'})<cr>")
		map("n", "<leader>;", "<cmd>lua Snacks.picker.resume()<cr>")
		map("n", "<leader>/", "<cmd>lua Snacks.picker.search_history({ layout = 'vscode' })<cr>")
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.select()<cr>")
		-- uses a fast frecency impl based on exponential decay and combines results from multiple finders (buffers, files and recent):
		map("n", "<leader>fs", "<cmd>lua Snacks.picker.smart()<cr>")
		-- not cursor layout capacity:
		-- map("n", "<leader>fp", "<cmd>lua Snacks.picker.spelling({layout = 'select'})<cr>")
		map("n", "<leader>ft", "<cmd>lua Snacks.picker.treesitter({layout = 'ivy_split'})<cr>")
		map("n", "<leader>fu", "<cmd>lua Snacks.picker.undo({ layout = 'sidebar' })<cr>")
		-- not working:
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.zoxide()<cr>")
		-- custom pickers:
		-- markdown headings
		map("n", "<leader>fh", function()
			snacks.picker.lines({
				layout = "sidebar",
				-- layout = {
				-- 	preview = "",
				-- 	-- fullscreen = true,
				-- },
				title = "Headings",
				pattern = "## ",
				on_show = function(picker)
					picker:show_preview()
				end,
			})
		end)
	end,
}
