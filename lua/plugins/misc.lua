return {
	-- LSP
	{
		"lvimuser/lsp-inlayhints.nvim",
		config = true,
	},
	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		event = "InsertEnter",
	},
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPre",
		config = true,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
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
	-- Navigation
	{
		"ggandor/leap.nvim",
		keys = { { "s", mode = { "n", "x" } }, { "S", mode = { "n", "x" } } },
		config = function()
			require("leap").add_default_mappings()
		end,
	},
	{
		"anuvyklack/windows.nvim",
		dependencies = "anuvyklack/middleclass",
		event = "WinNew",
		config = true,
	},
	{
		"xorid/swap-split.nvim",
		cmd = "SwapSplit",
		config = true,
	},
	{
		"xiyaowong/nvim-transparent",
		lazy = false,
		opts = {
			enable = true,
		},
	},
	{ "famiu/bufdelete.nvim", cmd = "Bdelete" },
	{
		"rhysd/clever-f.vim",
		keys = {
			{
				"f",
				mode = { "n", "x" },
			},
			{
				"F",
				mode = { "n", "x" },
			},
			{
				"t",
				mode = { "n", "x" },
			},
			{
				"T",
				mode = { "n", "x" },
			},
		},
	},
	-- Editing
	{
		"echasnovski/mini.trailspace",
		keys = {
			{
				"<leader>va",
				"<cmd>lua require('mini.trailspace').trim()<cr>",
			},
		},
	},
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
		cmd = "CccPick",
	},
	{
		"PatschD/zippy.nvim",
		keys = {
			{
				"<leader>vz",
				"<cmd>lua require('zippy').insert_print()<cr>",
			},
		},
	},
	{
		"Oldenborg/vim-px-to-rem",
		keys = {
			{
				"<leader>vp",
				"<cmd>Px!<cr>",
			},
			{
				"<leader>vr",
				"<cmd>Rem!<cr>",
			},
		},
	},
	-- Notes
	{ "nullchilly/fsread.nvim", ft = "norg" },
	-- Misc
	{
		"eandrju/cellular-automaton.nvim",
		cmd = "CellularAutomaton",
	},
}
