return {
	"folke/flash.nvim",
	opts = {
		labels = "jiofewasdghklqrtyupzxcvbnm",
		label = {
			uppercase = false,
		},
		modes = {
			search = {
				enabled = true,
			},
			char = {
				enabled = false,
			},
		},
	},
	keys = {
		{
			"s", -- (vim: (substitute) delete N characters [into register x] and start insert; (equivalent: cl))
			mode = { "n", "x", "o" }, -- (vim: delete highlighted area and start insert; (equivalent: v_c)
			function()
				require("flash").jump()
			end,
		},
		{
			"S", -- (vim: delete N lines [into register x] and start insert; synonym for "cc".)
			mode = { "n", "o", "x" }, -- (vim: delete the highlighted lines and start insert (equivalent: Vc, , unless already in linewise mode (then = v_c)))
			function()
				require("flash").treesitter()
			end,
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
		},
		{
			"<c-s>",
			mode = { "c" },
			function()
				require("flash").toggle()
			end,
		},
		{ "/" },
		{ "?" },
	},
}
