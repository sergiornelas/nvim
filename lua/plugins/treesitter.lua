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
			scope_incremental = "<c-x>",
			node_decremental = "<c-o>",
		},
	},
	textsubjects = {
		enable = true,
		keymaps = {
			["o"] = "textsubjects-smart",
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
