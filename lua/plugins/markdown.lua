return {
	{
		"laytan/cloak.nvim",
		ft = "markdown",
		config = function()
			require("cloak").setup({
				cloak_length = 9,
				-- Whether it should try every pattern to find the best fit or stop after the first.
				try_all_patterns = true,
				patterns = {
					{
						-- Match any file starting with '.env'.
						-- This can be a table to match multiple file patterns.
						file_pattern = "*.md",
						-- Match an equals sign and any character after it.
						-- This can also be a table of patterns to cloak,
						-- example: cloak_pattern = { ':.+', '-.+' } for yaml files.
						cloak_pattern = "::.+",
						-- A function, table or string to generate the replacement.
						replace = nil,
					},
				},
			})
		end,
	},
	{
		"crispgm/telescope-heading.nvim",
		keys = {
			{ "<leader>fh", "<cmd>Telescope heading<cr>" },
		},
	},
}
