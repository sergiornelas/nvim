return {
	{
		"eandrju/cellular-automaton.nvim",
		cmd = "CellularAutomaton",
		cond = not vim.g.vscode,
		keys = {
			{
				"<leader>\\",
				"<cmd>CellularAutomaton make_it_rain<cr>",
			},
		},
	},
	{
		"alanfortlink/animatedbg.nvim",
		cond = not vim.g.vscode,
		config = true,
		keys = {
			{
				"<leader>F",
				"<cmd>lua require('animatedbg-nvim').play({ animation = 'fireworks' })<cr>",
			},
		},
	},
	{
		"seandewar/killersheep.nvim",
		cond = not vim.g.vscode,
		keys = {
			{
				"<leader>`",
				"<cmd>KillKillKill<cr>",
			},
		},
	},
	-- TODO:
	-- https://github.com/cdmill/neomodern.nvim
	-- https://github.com/Jezda1337/nvim-html-css
	-- https://github.com/Sebastian-Nielsen/better-type-hover
	--   https://www.reddit.com/r/neovim/comments/1jzkuo7/new_plugin_show_actual_type_declaration_when/
	-- https://www.reddit.com/r/neovim/comments/1jwj0h2/reverse_engineered_cursor_tab_api_in_neovim/
	-- https://www.reddit.com/r/neovim/comments/1jw0zav/psa_heres_a_quick_guide_to_using_the_new_built_in/
	-- https://www.reddit.com/r/neovim/comments/1jyigwx/pickmenvim_a_unified_interface_for_telescope/
}
