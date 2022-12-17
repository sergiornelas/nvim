local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.api.nvim_exec([[packadd packer.nvim]], false)
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
	-- Sync without hanging after 70+ plugins
	max_jobs = 50,
	git = {
		clone_timeout = 300, -- Timeout, in seconds, for git clones
	},
})

-- Run :LuaCacheClear and eliminate main.shada each two weeks
return packer.startup(function(use)
	-- PACKER ----------------------------------------------------
	use("wbthomason/packer.nvim")

	-- STARTUP OPTIMIZATIONS -------------------------------------
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
		config = function()
			require("lsp.mason")
		end,
	})
	use("williamboman/mason-lspconfig.nvim")
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("lsp.null-ls")
		end,
	})
	use("jose-elias-alvarez/typescript.nvim")
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
		config = function()
			require("plugins.cmp")
		end,
	})
	use({
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-emoji",
		"onsails/lspkind.nvim",
		after = "nvim-cmp",
	})

	-- SNIPPETS --------------------------------------------------
	use({
		"L3MON4D3/LuaSnip",
		wants = "rafamadriz/friendly-snippets",
	})
	use("rafamadriz/friendly-snippets")

	-- TREESITTER ------------------------------------------------
	use({
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugins.treesitter")
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-context",
		"p00f/nvim-ts-Rainbow",
		"JoosepAlviste/nvim-ts-context-commentstring",
		after = "nvim-treesitter/nvim-treesitter",
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

	-- NAVIGATION ------------------------------------------------
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
		config = function()
			require("plugins.leap")
		end,
	})
	use("ggandor/leap-spooky.nvim")
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
	use({
		"ziontee113/neo-minimap",
		config = function()
			require("plugins.neo")
		end,
	})

	-- EDITING ---------------------------------------------------
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

	-- GIT -------------------------------------------------------
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

	-- FRONTEND DEVELOPMENT --------------------------------------
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

	-- COLORSCHEMES ----------------------------------------------
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

	-- NOTES -----------------------------------------------------
	use({
		"nvim-neorg/neorg",
		tag = "*",
		config = function()
			require("plugins.neorg")
		end,
	})
	use("nullchilly/fsread.nvim")

	-- MISC ------------------------------------------------------
	use("eandrju/cellular-automaton.nvim")

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
