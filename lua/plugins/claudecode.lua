return {
	{
		"coder/claudecode.nvim",
		lazy = false,
		enabled = true,
		opts = {
			terminal = {
				provider = (function()
					local kitty_pane_id = nil

					local function pane_exists(id)
						if not id then
							return false
						end
						vim.fn.system('kitty @ ls 2>/dev/null | grep -q \'"id": ' .. id .. "'")
						return vim.v.shell_error == 0
					end

					local function launch_pane(cmd_string, env_table)
						local env_args = ""
						for k, v in pairs(env_table or {}) do
							env_args = env_args .. "--env " .. k .. "=" .. v .. " "
						end
						local cwd = vim.fn.getcwd()
						vim.fn.system("kitty @ goto-layout tall")
						local result = vim.fn.system(
							"kitty @ launch --type=window --location=vsplit --title=claude --cwd="
								.. vim.fn.shellescape(cwd)
								.. " "
								.. env_args
								.. cmd_string
						)
						kitty_pane_id = tonumber(vim.trim(result))
					end

					local nvim_pane_id = tonumber(vim.fn.getenv("KITTY_WINDOW_ID"))

					vim.api.nvim_create_autocmd("BufWinEnter", {
						callback = function()
							local bufname = vim.api.nvim_buf_get_name(0)
							if bufname:match("%(proposed%)") or bufname:match("%(NEW FILE %- proposed%)") then
								if nvim_pane_id then
									vim.fn.system("kitty @ focus-window --match id:" .. nvim_pane_id)
								end
								-- Navigation mappings para diff de claudecode
								local opts = { buffer = true }
								vim.keymap.set("n", "<c-j>", function()
									vim.cmd.normal({ "]c", bang = true })
								end, opts)
								vim.keymap.set("n", "<c-k>", function()
									vim.cmd.normal({ "[c", bang = true })
								end, opts)
							end
						end,
					})

					return {
						is_available = function()
							return true
						end,

						setup = function() end,

						open = function(cmd_string, env_table)
							if kitty_pane_id and pane_exists(kitty_pane_id) then
								vim.fn.system("kitty @ goto-layout tall")
								vim.fn.system("kitty @ focus-window --match id:" .. kitty_pane_id)
							else
								launch_pane(cmd_string, env_table)
							end
						end,

						close = function()
							if kitty_pane_id then
								vim.fn.system("kitty @ close-window --match id:" .. kitty_pane_id)
								kitty_pane_id = nil
							end
						end,

						simple_toggle = function(cmd_string, env_table)
							if kitty_pane_id and pane_exists(kitty_pane_id) then
								vim.fn.system("kitty @ close-window --match id:" .. kitty_pane_id)
								kitty_pane_id = nil
							else
								launch_pane(cmd_string, env_table)
							end
						end,

						focus_toggle = function(cmd_string, env_table)
							if kitty_pane_id and pane_exists(kitty_pane_id) then
								vim.fn.system("kitty @ focus-window --match id:" .. kitty_pane_id)
							else
								launch_pane(cmd_string, env_table)
							end
						end,

						get_active_bufnr = function()
							return nil
						end,
					}
				end)(),
			},
			-- Diff Integration
			diff_opts = {
				layout = "vertical", -- "vertical" or "horizontal"
				open_in_new_tab = true,
				keep_terminal_focus = false, -- If true, moves focus back to terminal after diff opens. [Doesn't work with my current custom provider].
				hide_terminal_in_new_tab = false,
				-- on_new_file_reject = "keep_empty", -- "keep_empty" or "close_window"

				-- Legacy aliases (still supported):
				-- vertical_split = true,
				-- open_in_current_tab = true,
			},
		},
		keys = {
			{ "<leader>a", nil, desc = "AI/Claude Code" },
			{ "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
			-- { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
			{ "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
			{ "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
			{ "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
			{ "go", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" }, -- (vim: cursor to byte N in the buffer)
			{ "gl", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
			{
				"gll",
				function()
					local mode = vim.fn.mode()
					if mode == "v" or mode == "V" then
						vim.cmd("ClaudeCodeSend")
					else
						vim.cmd("normal! V")
						vim.cmd("ClaudeCodeSend")
					end
				end,
				desc = "Send selection or current line to Claude",
			},
			{
				"gll",
				"<cmd>ClaudeCodeTreeAdd<cr>",
				desc = "Add file",
				ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
			},
			-- { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" }, -- :w
			{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" }, -- :q
		},
	},
	{
		"cajames/copy-reference.nvim",
		opts = {},
		keys = {
			{ "<leader>y", "<cmd>CopyReference file<cr>", mode = { "n", "v" } },
			{ "<leader>Y", "<cmd>CopyReference line<cr>", mode = { "n", "v" } },
		},
	},
}
