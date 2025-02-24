return {
	"folke/flash.nvim",
	opts = {
		labels = "jiofewasdghklqrtyupzxcvbnm",
		label = {
			uppercase = false,
		},
		modes = {
			search = {
				enabled = false,
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
	},
	specs = {
		{
			"folke/snacks.nvim",
			opts = {
				picker = {
					win = {
						input = {
							keys = {
								["<c-space><c-s>"] = { "flash", mode = { "n", "i" } },
								["s"] = { "flash" },
							},
						},
					},
					actions = {
						flash = function(picker)
							require("flash").jump({
								pattern = "^",
								label = { after = { 0, 0 } },
								search = {
									mode = "search",
									exclude = {
										function(win)
											return vim.bo[vim.api.nvim_win_get_buf(win)].filetype
												~= "snacks_picker_list"
										end,
									},
								},
								action = function(match)
									local idx = picker.list:row2idx(match.pos[1])
									picker.list:_move(idx, true, true)
								end,
							})
						end,
					},
				},
			},
		},
	},
}
