return {
	"nvimdev/lspsaga.nvim",
	lazy = false,
	config = function()
		require("lspsaga").setup({
			symbol_in_winbar = {
				enable = false,
				show_file = false,
			},
			code_action = {
				show_server_name = true,
				keys = {
					quit = "<esc>",
				},
			},
			definition = {
				keys = {
					edit = "<c-c>o",
					vsplit = "<c-c>v",
					split = "<c-c>s",
					tabe = "<c-c>r",
					quit = "q",
					close = "<esc>",
				},
			},
			diagnostic = {
				keys = {
					exec_action = "<cr>",
					quit = "<esc>",
					toggle_or_jump = "o",
					quit_in_show = { "q", "<esc>" },
				},
			},
			finder = {
				left_width = 0.4,
				right_width = 0.5,
				default = "ref",
				-- layout = "normal", -- not working
				keys = {
					shuttle = "<c-o>", -- shuttle bettween the finder layout window
					toggle_or_open = "<cr>",
					vsplit = "v",
					split = "s",
					tabe = "r",
					tabnew = "R",
					quit = "<esc>",
					close = "<C-c>k",
				},
			},
			lightbulb = {
				virtual_text = false,
			},
			outline = {
				win_position = "right",
				win_width = 45,
				close_after_jump = false,
				keys = {
					toggle_or_jump = "<cr>",
					quit = "<esc>",
					jump = "e",
				},
			},
			rename = {
				in_select = true,
				keys = {
					quit = "<esc>",
					exec = "<cr>",
					select = "<space>",
				},
			},
		})
	end,
}
