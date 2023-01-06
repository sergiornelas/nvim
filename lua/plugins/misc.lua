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
		config = {
			use_default_keymaps = false,
		},
		cmd = "TSJToggle",
	},
	-- Navigation
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
		config = {
			enable = true,
		},
	},
	{ "famiu/bufdelete.nvim", cmd = "Bdelete" },
	{ "rhysd/clever-f.vim", keys = {
		"f",
		"F",
		"t",
		"T",
	} },
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
	{
		"chrisgrieser/nvim-various-textobjs",
		event = "BufReadPost",
		config = {
			useDefaultKeymaps = true,
		},
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
