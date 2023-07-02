return {
	{
		"nvim-neotest/neotest",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"haydenmeade/neotest-jest",
		},
		keys = {
			{
				"<leader>tl",
				function()
					require("neotest").run.run_last()
				end,
			},
			{
				"<leader>tt",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
			},
			{
				"<leader>tT",
				function()
					require("neotest").run.run(vim.loop.cwd())
				end,
			},
			{
				"<leader>tj",
				function()
					require("neotest").run.run()
				end,
			},
			{
				"<leader>ts",
				function()
					require("neotest").summary.toggle()
				end,
			},
			{
				"<leader>tw",
				"<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>",
			},
			{
				"<leader>to",
				function()
					require("neotest").output.open({ enter = true, auto_close = true })
				end,
			},
			{
				"<leader>tp",
				function()
					require("neotest").output_panel.toggle()
				end,
			},
			{
				"<leader>tS",
				function()
					require("neotest").run.stop()
				end,
			},
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-jest")({
						jestCommand = "npm test --",
						-- jestCommand = "jest --watch ",
						-- jestConfigFile = "custom.jest.config.ts",
						jestConfigFile = "jest.config.js",
						env = { CI = true },
						cwd = function(path)
							return vim.fn.getcwd()
						end,
					}),
				},
			})
		end,
	},
}
