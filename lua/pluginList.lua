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
	-- HAVE PACKER MANAGE ITSELF ---------------------------------
	use({
		"wbthomason/packer.nvim",
	})

	-- STARTUP OPTIMIZATIONS -------------------------------------
	use({
		"nathom/filetype.nvim",
	})
	use({
		"tjdevries/lazy.nvim",
	})
	use({
		"lewis6991/impatient.nvim",
	})
	use({
		"tweekmonster/startuptime.vim",
		cmd = "StartupTime",
	})

	-- CMP -------------------------------------------------------
	use({
		"hrsh7th/nvim-cmp",
		config = function()
			require("plugins.cmp")
		end,
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
	-- LSP CMP
	use({
		"hrsh7th/cmp-nvim-lsp",
	})
	-- LUA CMP
	use({
		"hrsh7th/cmp-nvim-lua",
	})
	-- EMOJI CMP
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

	-- LSP -------------------------------------------------------
	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("lsp")
		end,
	})
	-- LSP INSTALLER----------------------------------------------
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	-- NULL-LS ---------------------------------------------------
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})
	-- LSP SAGA --------------------------------------------------
	use({
		-- check this plugin again when winbar is available
		"glepnir/lspsaga.nvim",
		branch = "main",
	})
	-- SIGNATURE -------------------------------------------------
	use({
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup()
		end,
	})
	-- NAVIC -----------------------------------------------------
	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	})
	-- ILLUMINATE ------------------------------------------------
	use({ "RRethy/vim-illuminate" })

	-- TREESITTER ------------------------------------------------
	use({
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugins.treesitter")
		end,
		run = ":TSUpdate",
	})
	-- TREESITTER UNIT -------------------------------------------
	use({ "David-Kunz/treesitter-unit" })

	-- COMMENTS --------------------------------------------------
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("plugins.comment")
		end,
	})
	-- JSX COMMENTS ----------------------------------------------
	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
		after = "nvim-treesitter",
	})

	-- AUTOTAG ---------------------------------------------------
	use({
		"windwp/nvim-ts-autotag",
		after = "nvim-treesitter",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	})

	-- TELESCOPE -------------------------------------------------
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

	-- PROJECT ---------------------------------------------------
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("plugins.project")
		end,
	})

	-- NVIM TREE -------------------------------------------------
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

	-- COLORIZER -------------------------------------------------
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("plugins.colorizer")
		end,
	})

	-- COLORPICKER -----------------------------------------------
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

	-- TRANSPARENT NVIM ------------------------------------------
	use({
		"xiyaowong/nvim-transparent",
		config = function()
			require("plugins.transparent")
		end,
	})

	-- GIT SIGNS -------------------------------------------------
	use({
		"lewis6991/gitsigns.nvim",
		event = "BufEnter",
		config = function()
			require("plugins.gitsigns")
		end,
	})
	-- GIT DIFF --------------------------------------------------
	use({
		"sindrets/diffview.nvim",
		config = function()
			require("plugins.gitdiff")
		end,
	})

	-- AUTOPAIRS -------------------------------------------------
	use({
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("plugins.autopairs")
		end,
	})
	-- LUALINE ---------------------------------------------------
	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("plugins.lualine")
		end,
	})

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

	-- LIGHTSPEED ------------------------------------------------
	use({
		"ggandor/leap.nvim",
		config = function()
			require("plugins.leap")
		end,
	})

	-- MAXIMIZER WINDOW ------------------------------------------
	use("szw/vim-maximizer")

	-- GOOGLE CALENDAR/TASKS -------------------------------------
	use("itchyny/calendar.vim")
	-- rm -rf ~/.cache/calendar.vim/google/

	-- SESSIONS --------------------------------------------------
	use({
		"rmagatti/auto-session",
		config = function()
			require("plugins.auto-session")
		end,
	})

	-- BUFFER NAVIGATION -----------------------------------------
	use({
		"ghillb/cybu.nvim",
		config = function()
			require("plugins.cybu")
		end,
	})
	-- HARPOON ---------------------------------------------------
	use({
		"ThePrimeagen/harpoon",
		config = function()
			require("plugins.harpoon")
		end,
	})

	-- BUFFER DELETE ---------------------------------------------
	use({ "famiu/bufdelete.nvim" })

	-- TAB OUT ---------------------------------------------------
	use({
		"abecodes/tabout.nvim",
		config = function()
			require("plugins.tabout")
		end,
	})

	-- REGISTERS -------------------------------------------------
	use({ "tversteeg/registers.nvim" })

	-- TODO-COMMENTS ---------------------------------------------
	use({
		"folke/todo-comments.nvim",
		config = function()
			require("todo-comments").setup()
		end,
	})

	-- EYE-LINER -------------------------------------------------
	use({
		"jinh0/eyeliner.nvim",
		config = function()
			require("eyeliner").setup({
				highlight_on_key = true,
			})
		end,
	})

	-- AUTO-SAVE -------------------------------------------------
	-- use({
	-- 	"Pocco81/auto-save.nvim",
	-- 	config = function()
	-- 		require("auto-save").setup()
	-- 	end,
	-- })

	-- REMOVED TREESITTER PLUGINS FOR GAIN FPS -------------------
	-- RAINBOW ---------------------------------------------------
	-- use({
	-- 	"p00f/nvim-ts-rainbow",
	-- 	commit = "837167f63445821c55e6eed9dbdac1b0b29afa92",
	-- })
	-- -- TREESITTER CONTEXT ------------------------------------- (slows fps)
	-- use({
	-- 	"nvim-treesitter/nvim-treesitter-context",
	-- 	config = function()
	-- 		require("plugins.treesitter-ctx")
	-- 	end,
	-- })
	-- TREESITTER ARGUMENTS -------------------------------------- (potential slows)
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
