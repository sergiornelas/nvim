---@diagnostic disable: undefined-field
return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/nvim-nio",
			"marilari88/neotest-vitest",
			-- "nvim-neotest/neotest-jest",
		},
		keys = {
			-- run the current file
			{
				"<leader>tf",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
			},
			-- whole project
			{
				"<leader>tC",
				function()
					require("neotest").run.run(vim.loop.cwd())
				end,
			},
			-- current test
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
				"<leader>to",
				function()
					require("neotest").output.open({ enter = true, auto_close = true })
				end,
			},
			-- open output panel into a new window in left side
			{
				"<leader>t;",
				function()
					require("neotest").output.open({ enter = true, auto_close = true })
					vim.defer_fn(function()
						vim.cmd("wincmd T")
					end, 20)
				end,
			},
			{
				"<leader>tp",
				function()
					require("neotest").output_panel.toggle()
				end,
			},
			{
				"<leader>tc",
				function()
					require("neotest").output_panel.clear()
				end,
			},
			{
				"<leader>t<leader>",
				function()
					require("neotest").run.stop()
				end,
			},
			-- {
			-- 	"<leader>tj",
			-- 	function()
			-- 		require("neotest").run.run_last()
			-- 	end,
			-- },
			-- {
			-- 	"<leader>tw",
			-- 	"<cmd>lua require('neotest').run.run({ vitestCommand = './node_modules/.bin/vitest --watch' })<cr>",
			-- },
			-- attach needs --watch to work
			-- {
			-- 	"<leader>ta",
			-- 	"<cmd>lua require('neotest').run.attach()<cr>",
			-- },
		},
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "neotest-output" },
				callback = function()
					local opts = { noremap = true, silent = true, buffer = true }
					vim.keymap.set("n", "q", "<cmd>wincmd q<cr>", opts)
					vim.keymap.set("n", "<esc>", "<cmd>wincmd q<cr>", opts)
				end,
			})
			require("neotest").setup({
				adapters = {
					-- require("neotest-jest")({
					-- 	jestCommand = "npm test --",
					-- 	-- jestCommand = "jest --watch ",
					-- 	-- jestConfigFile = "custom.jest.config.ts",
					-- 	jestConfigFile = "jest.config.js",
					-- 	env = { CI = true },
					-- 	cwd = function(path)
					-- 		return vim.fn.getcwd()
					-- 	end,
					-- }),
					require("neotest-vitest"),
				},
			})
		end,
	},
}
