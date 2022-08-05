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
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
local group = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd(
	"BufWritePost",
	{ pattern = "pluginList.lua", command = "source <afile> | PackerSync", group = group }
)

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
	-- Sync without hanging after 70+ plugins
	max_jobs = 50,
})

return packer.startup(function(use)
	-- PACKER ----------------------------------------------------
	use({
		"wbthomason/packer.nvim",
	})

	-- STARTUP OPTIMIZATIONS -------------------------------------
	use({
		"tweekmonster/startuptime.vim",
		cmd = "StartupTime",
	})
	use({
		"nathom/filetype.nvim",
	})
	use({
		"lewis6991/impatient.nvim",
	})

	-- LSP -------------------------------------------------------
	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("lsp")
		end,
	})
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		-- commit = "14ccbe682fb3060b70760468935dc306d67d876d",
		-- check this plugin again when winbar is available
	})
	use({
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup()
		end,
	})
	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	})
	use({ "RRethy/vim-illuminate" })

	-- CMP -------------------------------------------------------
	use({
		"hrsh7th/nvim-cmp",
		config = function()
			require("plugins.cmp")
		end,
	})
	use({
		"hrsh7th/cmp-nvim-lsp",
	})
	use({
		"hrsh7th/cmp-buffer",
	})
	use({
		"hrsh7th/cmp-path",
	})
	use({
		"saadparwaiz1/cmp_luasnip",
	})
	use({
		"hrsh7th/cmp-nvim-lua",
	})
	use({
		"hrsh7th/cmp-emoji",
	})

	-- SNIPPETS --------------------------------------------------
	use({
		"L3MON4D3/LuaSnip",
	})
	use({
		"rafamadriz/friendly-snippets",
	})

	-- TREESITTER ------------------------------------------------
	use({
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugins.treesitter")
		end,
		run = ":TSUpdate",
	})
	use({ "David-Kunz/treesitter-unit" })

	-- BUFFER NAVIGATION -----------------------------------------
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{
				"nvim-lua/plenary.nvim",
			},
		},
		run = "make",
		config = function()
			require("plugins.telescope")
		end,
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	-- use({ "crispgm/telescope-heading.nvim" }) --neorg
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("plugins.project")
		end,
	})
	use({
		"kyazdani42/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeRefresh", "NvimTreeClose" },
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("plugins.nvimtree")
		end,
	})
	use({
		"ThePrimeagen/harpoon",
		config = function()
			require("plugins.harpoon")
		end,
	})
	use({
		"ghillb/cybu.nvim",
		config = function()
			require("plugins.cybu")
		end,
	})
	use({
		"ggandor/leap.nvim",
		config = function()
			require("plugins.leap")
		end,
	})
	use({
		"xiyaowong/nvim-transparent",
		config = function()
			require("plugins.transparent")
		end,
	})
	use("szw/vim-maximizer")
	use({ "famiu/bufdelete.nvim" })

	-- GIT -------------------------------------------------------
	use({
		"lewis6991/gitsigns.nvim",
		event = "BufEnter",
		config = function()
			require("plugins.gitsigns")
		end,
	})
	use({
		"sindrets/diffview.nvim",
		config = function()
			require("plugins.gitdiff")
		end,
	})

	-- COMMENTS --------------------------------------------------
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("plugins.comment")
		end,
	})
	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
		after = "nvim-treesitter",
	})

	-- ENHANCERS -------------------------------------------------
	use({
		"rmagatti/auto-session",
		config = function()
			require("plugins.auto-session")
		end,
	})
	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("plugins.lualine")
		end,
	})
	use({
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("plugins.autopairs")
		end,
	})
	use({
		"abecodes/tabout.nvim",
		config = function()
			require("plugins.tabout")
		end,
	})
	use({
		"jinh0/eyeliner.nvim",
		config = function()
			require("eyeliner").setup({
				highlight_on_key = true,
			})
		end,
	})
	use({ "tversteeg/registers.nvim" })

	-- NOTES -----------------------------------------------------
	use({
		"nvim-neorg/neorg",
		requires = {
			"nvim-lua/plenary.nvim",
			-- "max397574/neorg-contexts",
			-- "nvim-neorg/neorg-telescope",
		},
		config = function()
			require("plugins.neorg")
		end,
	})
	use({
		"itchyny/calendar.vim",
		config = function()
			require("plugins.calendar")
		end,
	})
	-- rm -rf ~/.cache/calendar.vim/google/

	-- FRONTEND DEVELOPMENT --------------------------------------
	use({
		"windwp/nvim-ts-autotag",
		after = "nvim-treesitter",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	})
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("plugins.colorizer")
		end,
	})
	use({
		"ziontee113/color-picker.nvim",
		cmd = { "PickColor", "PickColorInsert" },
		config = function()
			require("plugins.color-picker")
		end,
	})

	-- COLORSCHEMES ----------------------------------------------
	use("lunarvim/darkplus.nvim")
	use("morhetz/gruvbox")
	use("sainnhe/gruvbox-material")
	use("luisiacc/gruvbox-baby")
	use("rebelot/kanagawa.nvim")
	use("nxvu699134/vn-night.nvim")
	use("folke/tokyonight.nvim")
	use("marko-cerovac/material.nvim")
	use("ishan9299/nvim-solarized-lua")
	use("savq/melange")
	use("Mofiqul/dracula.nvim")
	use("sainnhe/everforest")
	use("sainnhe/sonokai")
	use("shaeinst/roshnivim-cs")
	use("ray-x/aurora")
	use("fenetikm/falcon")
	use("yashguptaz/calvera-dark.nvim")
	use("projekt0n/github-nvim-theme")
	use("rose-pine/neovim")
	use("olimorris/onedarkpro.nvim")
	use("rmehri01/onenord.nvim")
	use("tiagovla/tokyodark.nvim")
	use("cpea2506/one_monokai.nvim")
	use("sainnhe/edge")
	use({
		"catppuccin/nvim",
		as = "catppuccin",
	})
	use({
		"navarasu/onedark.nvim",
		config = function()
			require("plugins.colorschemes").onedark()
		end,
	})
	use({
		"EdenEast/nightfox.nvim",
		config = function()
			require("plugins.colorschemes").nightfox()
		end,
	})
	use({
		"glepnir/zephyr-nvim",
		requires = { "nvim-treesitter/nvim-treesitter", opt = true },
	})

	-- TODO-COMMENTS ---------------------------------------------
	--use({
	--"folke/todo-comments.nvim",
	--config = function()
	--require("todo-comments").setup()
	--end,
	--})
	-- AUTO-SAVE -------------------------------------------------
	-- use({
	-- 	"Pocco81/auto-save.nvim",
	-- 	config = function()
	-- 		require("auto-save").setup()
	-- 	end,
	-- })
	-- RAINBOW ---------------------------------------------------
	-- use({
	-- 	"p00f/nvim-ts-rainbow",
	-- 	commit = "837167f63445821c55e6eed9dbdac1b0b29afa92",
	-- })
	-- -- TREESITTER CONTEXT -------------------------------------
	-- use({
	-- 	"nvim-treesitter/nvim-treesitter-context",
	-- 	config = function()
	-- 		require("plugins.treesitter-ctx")
	-- 	end,
	-- })
	-- TREESITTER ARGUMENTS --------------------------------------
	-- use({
	-- 	"m-demare/hlargs.nvim",
	-- 	config = function()
	-- 		require("hlargs").setup()
	-- 	end,
	-- 	requires = { "nvim-treesitter/nvim-treesitter" },
	-- })
	-- NEW AUTOPAIRS ---------------------------------------------
	-- kylechui/nvim-surround
	-- LIGHTSPEED ------------------------------------------------
	-- use({
	-- 	"ggandor/lightspeed.nvim",
	-- 	config = function()
	-- 		require("lightspeed").setup({
	-- 			ignore_case = false,
	-- 			-- exit_after_idle_msecs = { unlabeled = 1000, labeled = 600 },
	-- 		})
	-- 	end,
	-- })
	-- JEST TESTING ----------------------------------------------
	-- use({
	-- 	"David-Kunz/jester",
	-- })
	-- DAP -------------------------------------------------------
	-- use("mfusseneger/nvim-dap")
	-- use("rcarriga/nvim-dap-ui")
	-- use("ravenxrz/DAPInstall.nvim")
	-- DEBUGGING -------------------------------------------------
	-- use "theHamsta/nvim-dap-virtual-text"
	-- use "Pocco81/DAPInstall.nvim"
	-- AERIAL ----------------------------------------------------
	-- use({
	-- 	"stevearc/aerial.nvim",
	-- 	module = "aerial",
	-- 	cmd = { "AerialToggle", "AerialOpen", "AerialInfo" },
	-- 	config = function()
	-- 		-- require("plugins.leap")
	-- 		require("aerial").setup({})
	-- 	end,
	-- })
	-- MARKS -----------------------------------------------------
	-- use({
	-- 	"chentoast/marks.nvim",
	-- 	require("marks").setup({
	-- 		mappings = {
	-- 			set_next = "m,",
	-- 			next = "m]",
	-- 			preview = "m;",
	-- 			set_bookmark0 = "m0",
	-- 			prev = false, -- pass false to disable only this default mapping
	-- 		},
	-- 	}),
	-- })
	-- -- TAB NINE -----------------------------------------------
	-- use({
	--   "tzachar/cmp-tabnine",
	--   run = "./install.sh",
	--   requires = "hrsh7th/nvim-cmp",
	-- })
	-- DETAILED INFO CMP -----------------------------------------
	-- use {
	--    "ray-x/lsp_signature.nvim",
	--    after = "nvim-lspconfig",
	--    config = function()
	--      require("plugins.others").signature()
	--    end,
	-- }
	-- TREESITTER CMP --------------------------------------------
	-- use {
	--   "ray-x/cmp-treesitter",
	--   after = "nvim-cmp",
	-- }
	-- NEOGIT ----------------------------------------------------
	-- use {
	--    "TimUntersberger/neogit",
	--    cmd = {
	--       "Neogit",
	--       "Neogit commit",
	--    },
	--    config = function()
	--       require "plugins.neogit"
	--    end,
	-- }
	-- INTERESTING PLUGINS ---------------------------------------
	-- https://github.com/b0o/simrat39/symbols-outline.nvim
	-- https://github.com/b0o/SchemaStore.nvim
	-- use "nvim-treesitter/nvim-treesitter-textobjects"
	-- folke/trouble.nvim
	-- kevinhwang91/nvim-bqf
	-- ruifm/gitlinker.nvim
	-- mattn/webapi-vim
	-- pwntester/octo.nvim
	-- use({ "andymass/vim-matchup" })
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
