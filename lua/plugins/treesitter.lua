local M = {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufReadPost",
		dependencies = {
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
				ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
			},
			"nvim-treesitter/nvim-treesitter-textobjects",
			"mrjones2014/nvim-ts-Rainbow",
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
					"norg",
					"scss",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
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
				rainbow = { --colorfull parenthesis, HTML/JSX tags
					enable = true,
					extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
					max_file_lines = nil, -- Do not enable for files with more than n lines, int
				},
				context_commentstring = { --JSX commments
					enable = true,
					enable_autocmd = false,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<c-_>",
						scope_incremental = "<c-_>",
						node_incremental = "<c-i>",
						node_decremental = "<c-o>",
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@call.outer",
							["if"] = "@call.inner",
							["aF"] = "@function.outer",
							["iF"] = "@function.inner",
							["ac"] = "@conditional.outer",
							["ic"] = "@conditional.inner",
							["aP"] = "@parameter.outer",
							["iP"] = "@parameter.inner",
							["aC"] = "@class.outer",
							["iC"] = "@class.inner",
							-- ["in"] = "@number.inner", -- works
							-- ["iv"] = "@assignment.lhs", -- goto name of variable declaration useful
							-- ["iv"] = "@assignment.rhs", -- value (this works)
							-- ["ik"] = "@attribute.inner", -- not working
							-- ["ik"] = "@frame.inner", -- not working
							-- ["ik"] = "@return.inner", -- not working
							-- ["ik"] = "@scopename.inner", -- not working
							-- ["ik"] = "@statement.outer", -- not working
						},
						include_surrounding_whitespace = true,
					},
					swap = {
						enable = true,
						swap_next = {
							["du"] = "@function.outer",
						},
						swap_previous = {
							["dp"] = "@function.outer",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["\\d"] = "@call.outer",
							["\\s"] = "@function.outer",
							["\\a"] = "@conditional.outer",
							["\\v"] = "@parameter.outer",
						},
						goto_previous_start = {
							["\\e"] = "@call.outer",
							["\\w"] = "@function.outer",
							["\\q"] = "@conditional.outer",
							["\\c"] = "@parameter.outer",
						},
					},
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPre",
		config = true,
	},
	{
		"m-demare/hlargs.nvim",
		config = true,
		event = "BufReadPost",
	},
	{
		"Wansmer/treesj",
		opts = {
			use_default_keymaps = false,
		},
		cmd = "TSJToggle",
	},
	{
		"Wansmer/sibling-swap.nvim",
		dependencies = { "nvim-treesitter" },
		opts = {
			keymaps = {
				["<C-.>"] = "swap_with_right",
				["<C-,>"] = "swap_with_left",
				["<space>>"] = "swap_with_right_with_opp",
				["<space><"] = "swap_with_left_with_opp",
			},
		},
		keys = {
			"<c-,>",
			"<c-.>",
			"<leader>>",
			"<leader><",
		},
	},
	{
		"max397574/neorg-contexts",
		ft = "norg",
	},
}

return M
