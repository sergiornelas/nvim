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
	{
		"Wansmer/sibling-swap.nvim",
		dependencies = { "nvim-treesitter" },
		config = true,
		keys = {
			"<c-,>",
			"<c-.>",
			"<leader>,",
			"<leader>.",
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
	{
		"jcdickinson/wpm.nvim",
		event = "BufReadPost",
		config = function()
			require("wpm").setup({})
		end,
	},
	-- Misc
	{
		"eandrju/cellular-automaton.nvim",
		cmd = "CellularAutomaton",
	},
	-- {
	-- 	"rmagatti/goto-preview",
	-- 	config = function()
	-- 		require("goto-preview").setup({})
	-- 	end,
	-- },
}
