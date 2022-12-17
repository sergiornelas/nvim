-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	vim.cmd([[packadd packer.nvim]])
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
	return
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
		keybindings = {
			quit = "<c-j>",
		},
	},
	max_jobs = 50, -- Sync without hanging after 70+ plugins
	git = {
		clone_timeout = 300, -- Timeout, in seconds, for git clones
	},
})

-- Run :LuaCacheClear and eliminate main.shada each two weeks
packer.startup(function(use)
	-- Packer ----------------------------------------------------
	use("wbthomason/packer.nvim")

	-- Startup optimizations -------------------------------------
	use("lewis6991/impatient.nvim")

	-- LSP -------------------------------------------------------
	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("lsp.configs").setup()
		end,
	})
	use({
		"williamboman/mason.nvim",
		requires = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			require("lsp.mason")
		end,
	})
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "jose-elias-alvarez/typescript.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			require("lsp.null-ls")
		end,
	})
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			require("plugins.lspsaga")
		end,
	})
	use({
		"lvimuser/lsp-inlayhints.nvim",
		config = function()
			require("plugins.inlayhints")
		end,
	})
	use({
		"SmiteshP/nvim-navic",
		config = function()
			require("plugins.navic")
		end,
	})
	use({
		"RRethy/vim-illuminate",
		config = function()
			require("plugins.illuminate")
		end,
	})

	-- CMP -------------------------------------------------------
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-emoji",
			"onsails/lspkind.nvim",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("plugins.cmp")
		end,
	})

	-- Snippets --------------------------------------------------
	use({
		"L3MON4D3/LuaSnip",
		requires = "rafamadriz/friendly-snippets",
	})

	-- Treesitter ------------------------------------------------
	use({
		"nvim-treesitter/nvim-treesitter",
		requires = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"p00f/nvim-ts-Rainbow",
		},
		config = function()
			require("plugins.treesitter")
		end,
	})
	use({
		"m-demare/hlargs.nvim",
		config = function()
			require("hlargs").setup()
		end,
	})
	use({
		"folke/paint.nvim",
		config = function()
			require("plugins.paint")
		end,
	})
	use({
		"Wansmer/treesj",
		config = function()
			require("plugins.treesj")
		end,
	})

	-- Navigation ------------------------------------------------
	use({
		"nvim-telescope/telescope.nvim",
		run = "make",
		config = function()
			require("plugins.telescope")
		end,
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({
		"rmagatti/auto-session",
		config = function()
			require("plugins.auto-session")
		end,
	})
	use({
		"rmagatti/session-lens",
		config = function()
			require("plugins.session-lens")
		end,
	})
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("plugins.nvimtree")
		end,
	})
	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("plugins.lualine")
		end,
	})
	use({
		"cbochs/grapple.nvim",
		config = function()
			require("plugins.grapple")
		end,
	})
	use({
		"kwkarlwang/bufjump.nvim",
		config = function()
			require("plugins.bufjump")
		end,
	})
	use({
		"anuvyklack/windows.nvim",
		requires = "anuvyklack/middleclass",
		config = function()
			require("plugins.windows")
		end,
	})
	use({
		"xorid/swap-split.nvim",
		config = function()
			require("plugins.swap-split")
		end,
	})
	use({
		"xiyaowong/nvim-transparent",
		config = function()
			require("plugins.transparent")
		end,
	})
	use({ "famiu/bufdelete.nvim", cmd = "Bdelete" })
	use({
		"ggandor/leap.nvim",
		requires = { "ggandor/leap-spooky.nvim" },
		config = function()
			require("plugins.leap")
		end,
	})
	use("rhysd/clever-f.vim")
	use({
		"petertriho/nvim-scrollbar",
		config = function()
			require("plugins.nvim-scrollbar")
		end,
	})
	use({
		"b0o/incline.nvim",
		config = function()
			require("plugins.incline")
		end,
	})

	-- Editing ---------------------------------------------------
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("plugins.comment")
		end,
	})
	use({
		"echasnovski/mini.indentscope",
		config = function()
			require("plugins.indentscope")
		end,
	})
	use({
		"windwp/nvim-autopairs",
		after = "nvim-cmp",
		config = function()
			require("plugins.autopairs")
		end,
	})
	use({
		"kylechui/nvim-surround",
		tag = "*",
		config = function()
			require("plugins.nvim-surround")
		end,
	})
	use({
		"https://github.com/nat-418/boole.nvim",
		config = function()
			require("plugins.boole")
		end,
	})
	use({
		"echasnovski/mini.trailspace",
		config = function()
			require("plugins.trailspace")
		end,
	})
	use({
		"zbirenbaum/neodim",
		event = "LspAttach",
		config = function()
			require("plugins.neodim")
		end,
	})
	use({
		"abecodes/tabout.nvim",
		event = "InsertEnter",
		config = function()
			require("plugins.tabout")
		end,
	})
	use({
		"tversteeg/registers.nvim",
		event = "InsertEnter",
		config = function()
			require("plugins.registers")
		end,
	})

	-- Git -------------------------------------------------------
	use({
		"lewis6991/gitsigns.nvim",
		ft = "gitcommit",
		event = "BufEnter",
		config = function()
			require("plugins.gitsigns")
		end,
	})
	use({
		"sindrets/diffview.nvim",
		config = function()
			require("plugins.diffview")
		end,
	})

	-- Frontend development --------------------------------------
	use({
		"windwp/nvim-ts-autotag",
		after = "nvim-treesitter",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	})
	use({
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("plugins.colorizer")
		end,
	})
	use({
		"uga-rosa/ccc.nvim",
		config = function()
			require("plugins.ccc")
		end,
	})
	use("PatschD/zippy.nvim")
	use("Oldenborg/vim-px-to-rem")
	use("marilari88/twoslash-queries.nvim")
	use({
		"ellisonleao/dotenv.nvim",
		config = function()
			require("dotenv").setup()
		end,
	})

	-- Colorschemes ----------------------------------------------
	use("raddari/last-color.nvim")
	use({
		"B4mbus/oxocarbon-lua.nvim",
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
	})
	use({
		"ellisonleao/gruvbox.nvim",
		config = function()
			require("plugins.colorschemes.gruvbox")
		end,
	})
	use({
		"lmburns/kimbox",
		config = function()
			require("plugins.colorschemes.kimbox")
		end,
	})
	use({
		"EdenEast/nightfox.nvim",
		config = function()
			require("plugins.colorschemes.nightfox")
		end,
	})
	use({
		"navarasu/onedark.nvim",
		config = function()
			require("plugins.colorschemes.onedark")
		end,
	})

	-- Notes -----------------------------------------------------
	use({
		"nvim-neorg/neorg",
		tag = "*",
		config = function()
			require("plugins.neorg")
		end,
	})
	use("nullchilly/fsread.nvim")

	-- Misc ------------------------------------------------------
	use("eandrju/cellular-automaton.nvim")

	if is_bootstrap then
		require("packer").sync()
	end
end)
