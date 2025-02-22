local map = vim.keymap.set
local opts = { noremap = true, silent = true }
map("n", "<c-n>", "<cmd>lua Snacks.words.jump(1, true)<cr>", opts) -- (vim: same as "j")
map("n", "<c-p>", "<cmd>lua Snacks.words.jump(-1, true)<cr>", opts) -- (vim: same as "k")
map("n", "<leader>G", "<cmd>lua Snacks.gitbrowse()<cr>", opts)
map("n", "<leader>N", "<cmd>lua Snacks.scratch()<cr>", opts)
map("n", "<leader>S", "<cmd>lua Snacks.scratch.select()<cr>", opts)
map("n", "<c-;>", "<cmd>lua Snacks.zen()<cr>", opts)

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- 3rd/image
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
		-- indent-blankline
		indent = {
			scope = {
				enabled = false,
			},
		},
		-- nui
		input = {},
		-- j-hui/fidget
		notifier = {
			timeout = 1200,
			width = { min = 15, max = 0.4 },
			margin = { top = 0, right = 1, bottom = 1 },
			icons = {
				error = " ",
				warn = " ",
				info = " ",
			},
			top_down = false, -- place notifications from top to bottom
		},
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
			notification = {
				border = "single",
			},
			notification_history = {
				border = "single",
			},
			snacks_image = {
				relative = "cursor", -- editor
				border = "single",
			},
		},
		-- vim-illuminate
		words = {
			debounce = 170, -- 200
		},
		-- zen-mode
		zen = {
			toggles = {
				dim = false,
			},
			on_open = function()
				vim.opt.scrolloff = 999
			end,
			on_close = function()
				vim.opt.scrolloff = 0
			end,
		},
	},
}
