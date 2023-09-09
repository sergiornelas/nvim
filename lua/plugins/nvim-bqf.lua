return {
	"kevinhwang91/nvim-bqf",
	ft = "qf",
	config = function()
		require("bqf").setup({
			preview = {
				win_height = 15, -- height of preview window for horizontal layout, large value (999) perform preview window as full model
				win_vheight = 15, -- The height of preview window for vertical layout
				wrap = false,
			},
			func_map = {
				open = "O",
				openc = "o",
				drop = "<cr>",
				tabdrop = "<c-k>",
				tab = "T",
				split = "<c-x>",
				vsplit = "<c-v>",
				prevfile = "K",
				nextfile = "J",
				stoggleup = "<c-o>",
				stoggledown = "<c-i>",
				stogglevm = "<c-j>",
				stogglebuf = "<c-s>",
				sclear = "<c-c>",
				pscrollup = "<c-b>",
				pscrolldown = "<c-f>",
				ptogglemode = "<c-z>",
				-- set to empty string to disable
				tabc = "",
				-- ptogglemode = "z,",
			},
		})
	end,
}
