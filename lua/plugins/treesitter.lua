return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "BufReadPost",
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-context",
			config = function()
				require("treesitter-context").setup({
					enable = true,
					max_lines = 0,
					line_numbers = true,
					multiline_threshold = 20, -- Maximum number of lines to show for a single context
				})
				local keymap = vim.keymap.set
				local opts = { noremap = true, silent = true }
				keymap({ "n", "x" }, "<leader>u", "<cmd>TSContextToggle<cr>", opts)
				keymap("i", "<c-g><c-t>", "<cmd>TSContextToggle<cr>", opts)
				keymap("n", "<leader>t0", "<cmd>lua require('treesitter-context').go_to_context(1)<cr>", opts)
				for i = 1, 9 do
					local cmd = "<cmd>lua require('treesitter-context').go_to_context(" .. i .. ")<cr>"
					keymap("n", "<leader>t" .. i, cmd, opts)
				end
				keymap("n", "<leader>tu", "<cmd>lua require('treesitter-context').go_to_context(99)<cr>", opts)
			end,
		},
		{
			"hiphish/rainbow-delimiters.nvim",
			config = function()
				local rainbow_delimiters = require("rainbow-delimiters")
				---@diagnostic disable-next-line: undefined-doc-name
				---@type rainbow_delimiters.config
				vim.g.rainbow_delimiters = {
					strategy = {
						[""] = rainbow_delimiters.strategy["global"],
						vim = rainbow_delimiters.strategy["local"],
					},
					query = {
						[""] = "rainbow-delimiters",
						lua = "rainbow-blocks",
					},
					priority = {
						[""] = 110,
						lua = 210,
					},
					highlight = {
						"RainbowDelimiterRed",
						"RainbowDelimiterYellow",
						"RainbowDelimiterBlue",
						"RainbowDelimiterOrange",
						"RainbowDelimiterGreen",
						"RainbowDelimiterViolet",
						"RainbowDelimiterCyan",
					},
				}
			end,
		},
	},
	config = function()
		local configs_ok, configs = pcall(require, "nvim-treesitter.configs")
		if not configs_ok then
			return
		end
		configs.setup({
			ensure_installed = {
				"bash",
				"css",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"regex",
				"scss",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
			sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
			auto_install = true,
			ignore_install = { "" }, -- List of parsers to ignore installing
			highlight = {
				enable = true, -- false will disable the whole extension
				disable = { "" }, -- list of language that will be disabled
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
			autopairs = { --automatic ({[]})
				enable = true,
			},
			autotag = { --HTML/JSX tags autorename
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = false,
					scope_incremental = false,
					node_incremental = "<c-r>",
					node_decremental = "<c-t>",
				},
			},
		})
	end,
}
