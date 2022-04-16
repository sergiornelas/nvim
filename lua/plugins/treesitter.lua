-- NEORG --------------
local present, parser_config = pcall(require, "nvim-treesitter.parsers")
if not present then
	return
end

-- Install norg extensions?
-- parser_config = parser_config.get_parser_configs()

parser_config.norg = {
	install_info = {
		url = "https://github.com/nvim-neorg/tree-sitter-norg",
		files = { "src/parser.c", "src/scanner.cc" },
		branch = "main",
	},
}

parser_config.norg_table = {
	install_info = {
		url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
		files = { "src/parser.c" },
		branch = "main",
	},
}

parser_config.norg_meta = {
	install_info = {
		url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
		files = { "src/parser.c" },
		branch = "main",
	},
}

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	textobjects = {
		select = {
			enable = true,
			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,
		},
	},
	ensure_installed = {
		"javascript",
		"css",
		"scss",
		"tsx",
		"vim",
		"html",
		"typescript",
		"lua",
		"json",
		"norg",
		"norg_table",
		"norg_meta",
		"bash",
	}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	indent = { enable = true, disable = { "yaml" } },
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
	},
	autopairs = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
	context_commentstring = { --JSX commments
		enable = true,
		enable_autocmd = false,
	},
})
