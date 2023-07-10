return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "BufReadPost",
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-context",
			config = true,
		},
		"nvim-treesitter/nvim-treesitter-textobjects",
		"hiphish/rainbow-delimiters.nvim",
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
						["in"] = "@number.inner",
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
}
