return {
	"rachartier/tiny-code-action.nvim",
	keys = {
		{
			"gra", -- (vim: vim.lsp.buf.code_action() (v0.11))
			"<cmd>lua require('tiny-code-action').code_action()<cr>",
			mode = { "n", "v" },
		},
	},
	opts = {
		-- picker = "snacks", -- move to new file freezes
		picker = {
			"buffer",
			opts = {
				hotkeys = true, -- Enable hotkeys for quick selection of actions
				hotkeys_mode = "text_diff_based", -- Modes for generating hotkeys
				auto_preview = true, -- Enable or disable automatic preview
				auto_accept = false, -- Automatically accept the selected action
				position = "cursor", -- Position of the picker window
				winborder = "single", -- Border style for picker and preview windows
				keymaps = {
					preview = "K", -- Key to show preview
					close = { "q", "<Esc>" }, -- Keys to close the window (can be string or table)
					select = "<c-j>", -- Keys to select action (can be string or table)
				},
				custom_keys = {
					{ key = "m", pattern = "Fill match arms" },
					{ key = "r", pattern = "Rename.*" }, -- Lua pattern matching
				},
			},
		},
	},
}
