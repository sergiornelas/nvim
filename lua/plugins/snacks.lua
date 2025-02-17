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
		image = {
			-- > brew install imagemagick
			-- > brew info imagemagick
			-- if pkgconf is missing:
			-- > brew install pkg-config
			doc = {
				inline = true, -- render the image inline in the buffer
				float = true, -- render the image in a floating window, only if doc.inline is disabled
				max_width = 80,
				max_height = 40,
			},
		},
		input = {},
		styles = {
			input = {
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
			snacks_image = {
				relative = "cursor", -- editor
				border = "single",
			},
		},
	},
}
