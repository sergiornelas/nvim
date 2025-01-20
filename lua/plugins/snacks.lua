---@diagnostic disable: undefined-global

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
		require("snacks").setup({
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
				enabled = true,
				win = {
					input = {
						keys = {
							["<esc>"] = { "close", mode = { "n", "i" } },
							["<c-j>"] = { "confirm", mode = { "n", "i" } },
							["<c-a>"] = { "select_all", mode = { "n", "i" } },
							["<c-z>"] = { "toggle_maximize", mode = { "i", "n" } },
							["<c-c>"] = { "toggle_preview", mode = { "i", "n" } },
							["<c-y>"] = { "cycle_win", mode = { "i", "n" } },
							["<c-[>"] = { "history_back", mode = { "i", "n" } },
							["<c-]>"] = { "history_forward", mode = { "i", "n" } },
							["<c-n>"] = { "select_and_next", mode = { "i", "n" } },
							["<c-p>"] = { "select_and_prev", mode = { "i", "n" } },
							["<c-i>"] = { "list_down", mode = { "i", "n" } },
							["<c-o>"] = { "list_up", mode = { "i", "n" } },
							["<c-g>"] = { "toggle_live", mode = { "i", "n" } },
							["<c-t><c-i>"] = { "toggle_ignored", mode = { "i", "n" } },
							["<c-t><c-h>"] = { "toggle_hidden", mode = { "i", "n" } },
						},
					},
					preview = {
						keys = {
							["a"] = "focus_input",
						},
					},
				},
				layout = layout,
			},
		})

		--- @param mode string|table
		--- @param key string
		--- @param command string|function
		local function map(mode, key, command)
			vim.keymap.set(mode, key, command, { noremap = true, silent = true })
		end

		-- map("n", "<leader>", "<cmd>lua Snacks.picker.autocmds()<cr>")
		map("n", "<leader>fo", function()
			Snacks.picker.buffers({
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
		map("n", "<leader>fi", function()
			Snacks.picker.files({
				exclude = {
					"/images",
					"/sounds",
				},
			})
		end)
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.git_branches()<cr>")
		map("n", "<leader>gs", "<cmd>lua Snacks.picker.git_diff()<cr>")
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.git_files()<cr>")
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.git_log()<cr>")
		-- no results found for git_log_file:
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.git_log_file()<cr>")
		-- command failed:
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.git_log_line()<cr>")
		-- show other project status:
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.git_status()<cr>")
		map("n", "<leader>fl", "<cmd>lua Snacks.picker.grep()<cr>")
		map("n", "<leader>fL", "<cmd>lua Snacks.picker.grep_buffers()<cr>")
		map({ "n", "x" }, "<leader>fw", "<cmd>lua Snacks.picker.grep_word()<cr>")
		map("n", "<leader>fh", "<cmd>lua Snacks.picker.help()<cr>")
		map("n", "<leader>H", "<cmd>lua Snacks.picker.highlights()<cr>")
		map("n", "<leader>fj", "<cmd>lua Snacks.picker.jumps()<cr>")
		map("n", "<leader>fk", "<cmd>lua Snacks.picker.keymaps()<cr>")
		map("n", "<leader>ff", "<cmd>lua Snacks.picker.lines()<cr>")
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.loclist()<cr>")
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.lsp_declarations()<cr>")
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.lsp_definitions()<cr>")
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.lsp_implementations()<cr>")
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.lsp_references()<cr>")
		map("n", "<leader>ly", "<cmd>lua Snacks.picker.lsp_symbols()<cr>")
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.lsp_type_definitions()<cr>")
		-- not working:
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.lsp_workspace_symbols()<cr>")
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.man()<cr>")
		map("n", "<leader>fm", "<cmd>lua Snacks.picker.marks({ layout = 'ivy' })<cr>")
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
		-- uses a fast frecency impl based on exponential decay and combines results from multiple finders (buffers, files and recent):
		map("n", "<leader>fs", "<cmd>lua Snacks.picker.smart()<cr>")
		-- not cursor layout capacity:
		-- map("n", "<leader>fp", "<cmd>lua Snacks.picker.spelling({layout = 'select'})<cr>")
		map("n", "<leader>fu", "<cmd>lua Snacks.picker.undo()<cr>")
		-- not working:
		-- map("n", "<leader>", "<cmd>lua Snacks.picker.zoxide()<cr>")
	end,
}
