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
		opts = {
			colorcolumn = "125",
		},
	},
	{
		"seandewar/killersheep.nvim",
		cmd = "KillKillKill",
	},
}
