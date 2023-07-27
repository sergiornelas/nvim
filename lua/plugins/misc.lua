return {
	{
		"eandrju/cellular-automaton.nvim",
		cmd = "CellularAutomaton",
		keys = {
			{
				"<leader>^",
				"<cmd>CellularAutomaton make_it_rain<cr>",
			},
		},
	},
	{
		"seandewar/killersheep.nvim",
		keys = {
			{
				"<leader>KK",
				"<cmd>KillKillKill<cr>",
			},
		},
	},
	-- { "NeogitOrg/neogit", dependencies = "nvim-lua/plenary.nvim", lazy = false, config = true },
	-- {
	-- 	"tiagovla/scope.nvim",
	-- 	lazy = false,
	-- 	config = function()
	-- 		require("scope").setup()
	-- 	end,
	-- },
}
