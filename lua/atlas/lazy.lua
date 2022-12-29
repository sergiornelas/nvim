-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

-- Run :LuaCacheClear and eliminate main.shada each two weeks
require("lazy").setup({
	-- LSP -------------------------------------------------------
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("atlas.lsp.configs").setup()
		end,
	},
	{
		"williamboman/mason.nvim",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			require("atlas.lsp.mason")
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "jose-elias-alvarez/typescript.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			require("atlas.lsp.null-ls")
		end,
	},
	{
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			require("atlas.plugins.lspsaga")
		end,
	},
	{
		"lvimuser/lsp-inlayhints.nvim",
		config = true,
	},
	{
		"SmiteshP/nvim-navic",
		config = function()
			require("atlas.plugins.navic")
		end,
	},
	{
		"RRethy/vim-illuminate",
		config = function()
			require("atlas.plugins.illuminate")
		end,
	},

	-- CMP -------------------------------------------------------
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-emoji",
			"onsails/lspkind.nvim",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("atlas.plugins.cmp")
		end,
	},

	-- Snippets --------------------------------------------------
	{
		"L3MON4D3/LuaSnip",
		dependencies = "rafamadriz/friendly-snippets",
	},

	-- Treesitter ------------------------------------------------
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"p00f/nvim-ts-Rainbow",
		},
		config = function()
			require("atlas.plugins.treesitter")
		end,
	},
	{
		"m-demare/hlargs.nvim",
		config = true,
	},
	{
		"folke/paint.nvim",
		config = function()
			require("atlas.plugins.paint")
		end,
	},
	{
		"Wansmer/treesj",
		config = function()
			require("atlas.plugins.treesj")
		end,
	},

	-- Navigation ------------------------------------------------
	{
		"nvim-telescope/telescope.nvim",
		build = "make",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("atlas.plugins.telescope")
		end,
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{
		"rmagatti/auto-session",
		config = function()
			require("atlas.plugins.auto-session")
		end,
	},
	{
		"rmagatti/session-lens",
		dependencies = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
		config = function()
			require("atlas.plugins.session-lens")
		end,
	},
	{
		"kyazdani42/nvim-tree.lua",
		dependencies = {
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("atlas.plugins.nvimtree")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("atlas.plugins.lualine")
		end,
	},
	{
		"cbochs/grapple.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("atlas.plugins.grapple")
		end,
	},
	{
		"kwkarlwang/bufjump.nvim",
		config = function()
			require("atlas.plugins.bufjump")
		end,
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
		config = function()
			require("atlas.plugins.transparent")
		end,
	},
	{ "famiu/bufdelete.nvim", cmd = "Bdelete" },
	{
		"ggandor/leap.nvim",
		dependencies = { "ggandor/leap-spooky.nvim" },
		config = function()
			require("atlas.plugins.leap")
		end,
	},
	"rhysd/clever-f.vim",
	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("atlas.plugins.nvim-scrollbar")
		end,
	},
	{
		"b0o/incline.nvim",
		config = function()
			require("atlas.plugins.incline")
		end,
	},

	-- Editing ---------------------------------------------------
	{
		"numToStr/Comment.nvim",
		config = function()
			require("atlas.plugins.comment")
		end,
	},
	{
		"echasnovski/mini.indentscope",
		config = function()
			require("atlas.plugins.indentscope")
		end,
	},
	{
		"windwp/nvim-autopairs",
		dependencies = "nvim-cmp",
		config = function()
			require("atlas.plugins.autopairs")
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		config = function()
			require("atlas.plugins.nvim-surround")
		end,
	},
	{
		"nat-418/boole.nvim",
		config = function()
			require("atlas.plugins.boole")
		end,
	},
	{
		"echasnovski/mini.trailspace",
		config = function()
			require("atlas.plugins.trailspace")
		end,
	},
	{
		"zbirenbaum/neodim",
		event = "LspAttach",
		config = function()
			require("atlas.plugins.neodim")
		end,
	},
	{
		"abecodes/tabout.nvim",
		event = "InsertEnter",
		config = function()
			require("atlas.plugins.tabout")
		end,
	},
	{
		"tversteeg/registers.nvim",
		event = "InsertEnter",
		config = true,
	},

	-- Git -------------------------------------------------------
	{
		"lewis6991/gitsigns.nvim",
		ft = "gitcommit",
		event = "BufEnter",
		config = function()
			require("atlas.plugins.gitsigns")
		end,
	},
	{
		"sindrets/diffview.nvim",
		config = function()
			require("atlas.plugins.diffview")
		end,
	},

	-- Frontend development --------------------------------------
	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("atlas.plugins.colorizer")
		end,
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

	-- Colorschemes ----------------------------------------------
	{
		"raddari/last-color.nvim",
		config = function()
			local theme = require("last-color").recall() or "gruvbox"
			vim.api.nvim_exec(("colorscheme %s"):format(theme), false)
		end,
	},
	{
		"B4mbus/oxocarbon-lua.nvim",
		"EdenEast/nightfox.nvim",
		"Shatur/neovim-ayu",
		"catppuccin/nvim",
		"cpea2506/one_monokai.nvim",
		"folke/tokyonight.nvim",
		"katawful/kat.nvim",
		"luisiacc/gruvbox-baby",
		"rebelot/kanagawa.nvim",
		"rose-pine/neovim",
		"sainnhe/edge",
		"sainnhe/gruvbox-material",
		"sainnhe/sonokai",
		"sam4llis/nvim-tundra",
		"tiagovla/tokyodark.nvim",
	},
	{
		"ellisonleao/gruvbox.nvim",
		config = function()
			require("atlas.plugins.colorschemes.gruvbox")
		end,
	},
	{
		"lmburns/kimbox",
		config = function()
			require("atlas.plugins.colorschemes.kimbox")
		end,
	},
	{
		"navarasu/onedark.nvim",
		config = function()
			require("atlas.plugins.colorschemes.onedark")
		end,
	},

	-- Notes -----------------------------------------------------
	{
		"nvim-neorg/neorg",
		version = "*",
		config = function()
			require("atlas.plugins.neorg")
		end,
		-- ft = "norg",
		-- run = ":Neorg sync-parsers", -- This is the important bit
	},
	"nullchilly/fsread.nvim",

	-- Misc ------------------------------------------------------
	"eandrju/cellular-automaton.nvim",
}, {
	defaults = {
		lazy = false,
	},
	checker = {
		enabled = true,
		frequency = 3600, -- check for updates every hour
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"bugreport",
				"compiler",
				"ftplugin",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"matchit",
				"matchparen",
				"netrw",
				"netrwFileHandlers",
				"netrwPlugin",
				"netrwSettings",
				"optwin",
				"rplugin",
				"rrhelper",
				"spellfile_plugin",
				"synmenu",
				"syntax",
				"tar",
				"tarPlugin",
				"tohtml",
				"tutor",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
			},
		},
	},
})
