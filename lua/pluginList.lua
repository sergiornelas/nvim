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
	use("ray-x/aurora")
	use("folke/tokyonight.nvim")
	use("marko-cerovac/material.nvim")

	-- TRANSPARENT NVIM --------------------------------
	use({
		"xiyaowong/nvim-transparent",
		config = function()
			require("transparent").setup({
				enable = true,
			})
		end,
	})

	-- CMP ---------------------------------------------
	use({
		"hrsh7th/nvim-cmp",
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
		"hrsh7th/cmp-cmdline",
		after = "nvim-cmp",
	})
	use({
		"saadparwaiz1/cmp_luasnip",
		after = "LuaSnip",
	})
	-- LSP CMP
	use({
		"hrsh7th/cmp-nvim-lsp",
		after = "nvim-lspconfig",
	})
	-- LUA CMP
	use({
		"hrsh7th/cmp-nvim-lua",
		after = "nvim-cmp",
	})
	-- DETAILED INFO CMP
	-- use {
	--    "ray-x/lsp_signature.nvim",
	--    after = "nvim-lspconfig",
	--    config = function()
	--      require("plugins.others").signature()
	--    end,
	-- }
	-- TREESITTER CMP
	-- use {
	--   "ray-x/cmp-treesitter",
	--   after = "nvim-cmp",
	-- }

	-- SNIPPETS ------------------------------------------
	use({
		"L3MON4D3/LuaSnip",
	})
	use({
		"rafamadriz/friendly-snippets",
		event = "InsertEnter",
	})

	-- LSP ----------------------------------------------
	use({
		"neovim/nvim-lspconfig",
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

	-- COMMENTS --------------------------------------------
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("plugins.others").comment()
		end,
	})
	-- JSX COMMENTS
	use({
		"JoosepAlviste/nvim-ts-context-commentstring", --heavy plugin (0.784)
	})
	-- AUTOTAG
	use({
		"windwp/nvim-ts-autotag",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	})

	use("nvim-treesitter/nvim-treesitter-textobjects")

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
	-- use "nvim-telescope/telescope-media-files.nvim"

	-- NVIM TREE ------------------------------------------
	use({
		"kyazdani42/nvim-tree.lua",
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
		config = function()
			require("plugins.others").colorizer()
		end,
	})

	-- GIT SIGNS -------------------------------------------
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("plugins.gitsigns")
		end,
	})
	-- GIT DIFF --------------------------------------------------
	use({
		"sindrets/diffview.nvim", --heavy plugin (+3.8)
		cmd = { "DiffviewOpen" },
		config = function()
			require("plugins.others").gitdiff()
		end,
	})

	-- AUTOPAIRS ---------------------------------------------
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("plugins.autopairs")
		end,
	})

	-- TERMINAL ------------------------------------------------
	use({
		"akinsho/toggleterm.nvim",
		config = function()
			require("plugins.toggleterm")
		end,
	})

	-- PROJECT --------------------------------------------------
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				manual_mode = true,
				detection_methods = {},
				patterns = {},
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
	use({
		"nvim-neorg/neorg-telescope",
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
		"ggandor/lightspeed.nvim",
		config = function()
			require("lightspeed").setup({
				ignore_case = false,
				exit_after_idle_msecs = { unlabeled = 1000, labeled = 600 },
			})
		end,
	})

	-- HARD MODE --------------------------------------------
	use("takac/vim-hardtime")

	-- MAXIMIZER WINDOW -------------------------------------
	use("szw/vim-maximizer")

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
