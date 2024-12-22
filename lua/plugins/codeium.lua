return {
	"Exafunction/codeium.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("codeium").setup({
			enable_cmp_source = false,
			virtual_text = {
				enabled = true,
				manual = false,
				filetypes = {
					TelescopePrompt = false,
				},
				default_filetype_enabled = true,
				idle_delay = 75,
				virtual_text_priority = 65535,
				map_keys = true,
				accept_fallback = nil,
				key_bindings = {
					accept = "<c-f>",
					accept_word = "<c-g><c-w>",
					accept_line = "<c-g><c-l>",
					clear = "<c-l>",
					prev = "<c-;>",
				},
			},
		})

		vim.keymap.set("i", "<c-space>", function()
			require("blink.cmp").cancel()
			require("codeium.virtual_text").cycle_or_complete()
		end)
	end,
}
