local fn = vim.fn

-- Automatically install Packer
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
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost pluginList.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Packer popup
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	-- HAVE PACKER MANAGE ITSELF -----------------------
	use({
		"wbthomason/packer.nvim",
	})

	-- STARTUP OPTIMIZATIONS ---------------------------
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

	-- COLORSCHEMES ---------------------------------------
	use("lunarvim/darkplus.nvim")
	use("ellisonleao/gruvbox.nvim")
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
			require("onedark").setup({
				toggle_style_key = "<leader>x",
				style = "deep",
			})
		end,
	})
	use({
		"EdenEast/nightfox.nvim",
		config = function()
			require("nightfox").setup({
				options = {
					transparent = false, -- Disable setting background
				},
			})
		end,
	})

	-- TRANSPARENT NVIM --------------------------------
	use({
		"xiyaowong/nvim-transparent",
		config = function()
			require("transparent").setup({
				enable = false,
			})
		end,
	})

	-- CMP ---------------------------------------------
	use({
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		after = "friendly-snippets",
		config = function()
			require("plugins.cmp")
		end,
	})
	use({
		"hrsh7th/cmp-buffer",
		after = "nvim-cmp",
	})
	use({
		"hrsh7th/cmp-path",
		after = "nvim-cmp",
	})
	use({
		"saadparwaiz1/cmp_luasnip",
		after = "nvim-cmp",
	})
	-- LSP CMP
	use({
		"hrsh7th/cmp-nvim-lsp",
		after = "nvim-cmp",
	})
	-- LUA CMP
	use({
		"hrsh7th/cmp-nvim-lua",
		after = "nvim-cmp",
	})

	-- SNIPPETS ------------------------------------------
	use({
		"L3MON4D3/LuaSnip",
		module = "luasnip",
		wants = "friendly-snippets",
	})
	use({
		"rafamadriz/friendly-snippets",
		event = "InsertEnter",
		opt = true,
	})

	-- LSP ----------------------------------------------
	use({
		"neovim/nvim-lspconfig",
		event = "VimEnter",
		after = "nvim-lsp-installer",
		config = function()
			require("lsp")
		end,
	})
	use({
		"williamboman/nvim-lsp-installer",
		config = function()
			require("lsp")
		end,
	})

	-- NULL-LS -------------------------------------------
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})
	use({
		"jose-elias-alvarez/nvim-lsp-ts-utils",
	})

	-- TREESITTER -----------------------------------------
	use({
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugins.treesitter")
		end,
		run = ":TSUpdate",
	})
	-- RAINBOW ---------------------------------------------
	use({
		"p00f/nvim-ts-rainbow",
		after = "nvim-treesitter",
	})

	-- TREESITTER UNIT ------------------------------------
	use({ "David-Kunz/treesitter-unit" })

	-- COMMENTS --------------------------------------------
	use({
		"numToStr/Comment.nvim",
		module = { "Comment", "Comment.api" },
		keys = { "gc", "gb", "g<", "g>" },
		config = function()
			require("plugins.others").comment()
		end,
	})
	-- JSX COMMENTS
	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
		after = "nvim-treesitter",
	})

	-- AUTOTAG ---------------------------------------------
	use({
		"windwp/nvim-ts-autotag",
		after = "nvim-treesitter",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	})

	-- TELESCOPE ------------------------------------------
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				"nvim-lua/plenary.nvim",
				run = "make",
			},
		},
		config = function()
			require("plugins.telescope")
		end,
	})

	-- NVIM TREE ------------------------------------------
	use({
		"kyazdani42/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeRefresh" },
		config = function()
			require("plugins.nvimtree")
		end,
	})
	-- DEVICONS
	use({
		"kyazdani42/nvim-web-devicons",
	})

	-- COLORIZER ------------------------------------------
	use({
		"norcalli/nvim-colorizer.lua",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("plugins.others").colorizer()
		end,
	})

	-- GIT SIGNS -------------------------------------------
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
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		config = function()
			require("plugins.others").gitdiff()
		end,
	})

	-- AUTOPAIRS ---------------------------------------------
	use({
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("plugins.autopairs")
		end,
	})

	-- PROJECT --------------------------------------------------
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				manual_mode = true, --responsible for bug when open new sessions with tabs
				--still not working properly (15/04/22)
			})
		end,
	})

	-- ROOTER .GIT FOLDER (TRULY WORKS) -------------------------
	use("airblade/vim-rooter")

	-- LUALINE --------------------------------------------------
	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("plugins.lualine")
		end,
	})
	-- GPS -----------------------------
	use({
		"SmiteshP/nvim-gps",
		config = function()
			require("nvim-gps").setup()
		end,
	})

	-- NOTES -------------------------------------------------
	use({
		"nvim-neorg/neorg",
		setup = vim.cmd("autocmd BufRead,BufNewFile *.norg setlocal filetype=norg"),
		after = { "nvim-treesitter" }, -- you may also specify telescope
		ft = "norg",
		config = function()
			require("plugins.neorg")
		end,
		requires = "nvim-lua/plenary.nvim",
	})

	-- BUFFERLINE --------------------------------------------------
	use({
		"akinsho/bufferline.nvim",
		after = "nvim-web-devicons",
		config = function()
			require("plugins.bufferline")
		end,
	})

	-- BUFFER DELETE --------------------------------------------------
	use({
		"famiu/bufdelete.nvim",
		cmd = { "Bdelete", "Bwipeout", "Bdelete!", "Bwipeout!" },
	})

	-- LIGHTSPEED -------------------------------------------
	use({
		"ggandor/leap.nvim",
		config = function()
			require("plugins.leap")
		end,
	})
	-- use({
	-- 	"ggandor/lightspeed.nvim",
	-- 	config = function()
	-- 		require("lightspeed").setup({
	-- 			ignore_case = false,
	-- 			-- exit_after_idle_msecs = { unlabeled = 1000, labeled = 600 },
	-- 		})
	-- 	end,
	-- })

	-- MAXIMIZER WINDOW ----------------------------------
	use("szw/vim-maximizer")

	-- GOOGLE CALENDAR/TASKS -----------------------------
	use("itchyny/calendar.vim")
	-- rm -rf ~/.cache/calendar.vim/google/

	-- JEST TESTING -----------------------------
	use({
		"David-Kunz/jester",
	})

	use({ "antoinemadec/FixCursorHold.nvim" })
	-- use({ "RRethy/vim-illuminate" })
	-- https://github.com/RRethy/vim-illuminate

	-- use({ "sergiornelas/vim-tmux-navigator", commit = "9ca5bfe5bd274051b5dd796cc150348afc993b80" })

	-- DAP -----------------------------
	-- use("mfusseneger/nvim-dap")
	-- use("rcarriga/nvim-dap-ui")
	-- use("ravenxrz/DAPInstall.nvim")

	-- use({
	-- 	"stevearc/aerial.nvim",
	-- 	module = "aerial",
	-- 	cmd = { "AerialToggle", "AerialOpen", "AerialInfo" },
	-- 	config = function()
	-- 		-- require("plugins.leap")
	-- 		require("aerial").setup({})
	-- 	end,
	-- })

	-- Session manager
	-- ["Shatur/neovim-session-manager"] = {
	--   module = "session_manager",
	--   cmd = "SessionManager",
	--   event = "BufWritePost",
	--   config = function()
	--     require "configs.session_manager"
	--   end,
	-- },

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
	-- -- TAB NINE ------------------------------------------
	-- use({
	--   "tzachar/cmp-tabnine",
	--   run = "./install.sh",
	--   requires = "hrsh7th/nvim-cmp",
	-- })
	-- TELESCOPE MEDIA FILES --------------------------------
	-- use "nvim-telescope/telescope-media-files.nvim"
	-- DETAILED INFO CMP ------------------------------------
	-- use {
	--    "ray-x/lsp_signature.nvim",
	--    after = "nvim-lspconfig",
	--    config = function()
	--      require("plugins.others").signature()
	--    end,
	-- }
	-- TREESITTER CMP ---------------------------------------
	-- use {
	--   "ray-x/cmp-treesitter",
	--   after = "nvim-cmp",
	-- }
	-- COPILOT ----------------------------------------------
	-- LSP (and copilot
	-- use {
	--    "github/copilot.vim",
	--    event = "InsertEnter",
	-- }
	-- NEOGIT -----------------------------------------------
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
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
