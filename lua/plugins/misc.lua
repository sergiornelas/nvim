return {
	{
		"tversteeg/registers.nvim",
		event = "InsertEnter",
		config = true,
	},
	{
		"fedepujol/move.nvim",
		cmd = { "MoveBlock", "MoveHBlock" },
	},
	{
		"eandrju/cellular-automaton.nvim",
		cmd = "CellularAutomaton",
	},
	{
		"m4xshen/smartcolumn.nvim",
		ft = "norg",
		config = function()
			require("smartcolumn").setup({
				colorcolumn = "125",
			})
		end,
	},
	{
		"seandewar/killersheep.nvim",
		cmd = "KillKillKill",
	},
}
