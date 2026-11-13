return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	keys = {
		{
			"<leader>u",
			function()
				require("copilot.suggestion").toggle_auto_trigger() -- current buffer only
			end,
			desc = "Toggle Copilot suggestions",
		},
	},
	config = function()
		require("copilot").setup({
			panel = { enabled = false },
			suggestion = {
				enabled = true,
				auto_trigger = true,
				hide_during_completion = true, -- hide ghost text while the blink.cmp menu is open
				keymap = {
					accept = "<c-;>",
					accept_word = "<c-f>", -- (vim: not used (but by default it's in 'cinkeys' to re-indent the current line))
					accept_line = "<c-l>",
					next = false,
					prev = false,
					dismiss = "<c-]>", -- <c-space> belongs to blink.cmp
				},
			},
			filetypes = {
				markdown = true, -- disabled by default in copilot.lua; notes are the main use case
				cpp = false,
				oil = false,
				snacks_picker_input = false,
			},
		})
	end,
}
