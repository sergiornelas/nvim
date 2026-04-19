return {
	"rachartier/tiny-cmdline.nvim",
	-- TODO:
	-- It requires vim.opt.cmdheight = 0 to work, wait until updates
	lazy = true,
	config = function()
		require("tiny-cmdline").setup({
			width = {
				value = "60%", -- "N%" = fraction of editor columns, integer = absolute columns
				min = 40, -- minimum width in columns
				max = 60, -- maximum width in columns
			},
			position = {
				x = "50%", -- horizontal: "0%" = left, "50%" = center, "100%" = right
				y = "50%", -- vertical:   "0%" = top,  "50%" = center, "100%" = bottom
			},
			native_types = { "/", "?" },
			on_reposition = require("tiny-cmdline").adapters.blink,
		})
	end,
}
