return {
	{
		"eandrju/cellular-automaton.nvim",
		cmd = "CellularAutomaton",
		keys = {
			{
				"<leader>C",
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
			{
				"<leader>M",
				"<cmd>lua require('animatedbg-nvim').play({ animation = 'matrix' })<cr>",
			},
			{
				"<leader>B",
				"<cmd>lua require('animatedbg-nvim').play({ animation = 'demo' })<cr>",
			},
			{
				"<leader>S",
				"<cmd>lua require('animatedbg-nvim').stop_all()<cr>",
			},
		},
	},
	{
		"seandewar/killersheep.nvim",
		keys = {
			{
				"<leader>K",
				"<cmd>KillKillKill<cr>",
			},
		},
	},
	-- {
	-- 	"stevearc/aerial.nvim",
	-- 	opts = {},
	-- 	lazy = false,
	-- 	-- Optional dependencies
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- },
}
