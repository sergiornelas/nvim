return {
	{
		"eandrju/cellular-automaton.nvim",
		cmd = "CellularAutomaton",
		keys = {
			{
				"<leader>\\",
				"<cmd>CellularAutomaton make_it_rain<cr>",
			},
		},
	},
	{
		"alanfortlink/animatedbg.nvim",
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
		keys = {
			{
				"<leader>`",
				"<cmd>KillKillKill<cr>",
			},
		},
	},
	-- TODO:
	-- https://github.com/Jezda1337/nvim-html-css
	-- https://github.com/Sebastian-Nielsen/better-type-hover
	-- https://www.reddit.com/r/neovim/comments/1jw0zav/psa_heres_a_quick_guide_to_using_the_new_built_in/
}
