local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = {
		"bash",
		"html",
		"css",
		"scss",
		"javascript",
		"typescript",
		"tsx",
		"vim",
		"lua",
		"json",
		"markdown",
		"norg",
	}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	auto_install = true,
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true },
	textobjects = {
		select = {
			enable = true, -- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["io"] = "@block.inner",
				["ao"] = "@block.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>K"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>J"] = "@parameter.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			-- mappings are in keymaps.lua
		},
	},
	textsubjects = {
		enable = true,
		keymaps = {
			["o"] = "textsubjects-smart",
		},
	},
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
			init_selection = "<c-y>",
			node_incremental = "<tab>",
			scope_incremental = "<c-c>",
			node_decremental = "<c-o>",
		},
	},
})

-- NEORG --------------
local present, parser_config = pcall(require, "nvim-treesitter.parsers")
if not present then
	return
end

parser_config.norg = {
	install_info = {
		url = "https://github.com/nvim-neorg/tree-sitter-norg",
		files = { "src/parser.c", "src/scanner.cc" },
		branch = "main",
	},
}
