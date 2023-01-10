local M = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "BufReadPost",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"mrjones2014/nvim-ts-Rainbow",
	},
}

function M.config()
	local configs_ok, configs = pcall(require, "nvim-treesitter.configs")
	if not configs_ok then
		return
	end

	configs.setup({
		ensure_installed = {
			"bash",
			"css",
			"help",
			"html",
			"javascript",
			"json",
			"lua",
			"markdown",
			"norg",
			"scss",
			"tsx",
			"typescript",
			"vim",
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
				init_selection = "<c-y>",
				scope_incremental = "<c-c>",
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
				},
				include_surrounding_whitespace = true,
			},
			swap = {
				enable = true,
				swap_next = {
					["dp"] = "@parameter.inner",
					["dz"] = "@function.outer",
				},
				swap_previous = {
					["du"] = "@parameter.inner",
					["dq"] = "@function.outer",
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
end

return M
