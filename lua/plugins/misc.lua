return {
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
			colorcolumn = "123",
		},
	},
	{
		"seandewar/killersheep.nvim",
		cmd = "KillKillKill",
	},
	{
		"utilyre/sentiment.nvim",
		event = "BufReadPost",
		version = "*",
		config = true,
	},
}
