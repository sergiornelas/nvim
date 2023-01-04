return {
	-- LSP
	{
		"lvimuser/lsp-inlayhints.nvim",
		config = true,
	},
	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = "rafamadriz/friendly-snippets",
	},
	-- Treesitter
	{
		"m-demare/hlargs.nvim",
		config = true,
	},
	{
		"Wansmer/treesj",
		config = {
			use_default_keymaps = false,
		},
	},
	-- Navigation
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	{
		"anuvyklack/windows.nvim",
		dependencies = "anuvyklack/middleclass",
		config = true,
	},
	{
		"xorid/swap-split.nvim",
		config = true,
	},
	{
		"xiyaowong/nvim-transparent",
		config = {
			enable = true,
		},
	},
	{ "famiu/bufdelete.nvim", cmd = "Bdelete" },
	"rhysd/clever-f.vim",
	-- Editing
	"echasnovski/mini.trailspace",
	{
		"tversteeg/registers.nvim",
		event = "InsertEnter",
		config = true,
	},
	-- Frontend Development
	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	},
	{
		"uga-rosa/ccc.nvim",
		config = true,
	},
	"PatschD/zippy.nvim",
	"Oldenborg/vim-px-to-rem",
	"marilari88/twoslash-queries.nvim",
	{
		"ellisonleao/dotenv.nvim",
		config = true,
	},
	-- Notes
	"nullchilly/fsread.nvim",
	-- Misc
	"eandrju/cellular-automaton.nvim",
}
