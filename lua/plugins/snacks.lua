return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		indent = {
			scope = {
				enabled = false,
			},
		},
		-- image = {}, -- wait
		input = {},
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
	},
}
