return {
	{
		"tversteeg/registers.nvim",
		event = "InsertEnter",
		config = true,
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
}
