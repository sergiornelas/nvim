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
	{ pattern = "plugins.lua", command = "source <afile> | PackerSync", group = group }
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
	use("wbthomason/packer.nvim")

	-- STARTUP OPTIMIZATIONS -------------------------------------
	use({
		"tweekmonster/startuptime.vim",
		cmd = "StartupTime",
	})
	use({
		"nathom/filetype.nvim",
		"lewis6991/impatient.nvim",
	})

	-- LSP -------------------------------------------------------
	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("lsp")
		end,
	})
	use({ "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" })
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		-- check this plugin again when winbar is available
	})
	use({
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup()
		end,
		wants = "neovim/nvim-lspconfig",
	})
	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	})
	use({
		"lvimuser/lsp-inlayhints.nvim",
		config = function()
			require("lsp-inlayhints").setup()
		end,
	})
	use("RRethy/vim-illuminate")

	-- CMP -------------------------------------------------------
	use({
		"hrsh7th/nvim-cmp",
		-- event = "InsertEnter",
		config = function()
			require("plugins-config.cmp")
		end,
	})
	use({
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-emoji",
		after = "nvim-cmp",
	})

	-- SNIPPETS --------------------------------------------------
	use({
		"L3MON4D3/LuaSnip",
		wants = "rafamadriz/friendly-snippets",
	})
	use({
		"rafamadriz/friendly-snippets",
	})

	-- TREESITTER ------------------------------------------------
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("plugins-config.treesitter")
		end,
	})
	use({
		"drybalka/tree-climber.nvim",
		"JoosepAlviste/nvim-ts-context-commentstring",
		"p00f/nvim-ts-Rainbow",
		after = "nvim-treesitter/nvim-treesitter",
	})

	-- BUFFER/NAVIGATION -----------------------------------------
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{
				"nvim-lua/plenary.nvim",
			},
		},
		run = "make",
		config = function()
			require("plugins-config.telescope")
		end,
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	-- use({ "crispgm/telescope-heading.nvim" }) --neorg
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("plugins-config.project")
		end,
	})
	use({
		"rmagatti/auto-session",
		config = function()
			require("plugins-config.auto-session")
		end,
	})
	use({
		"kyazdani42/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeRefresh", "NvimTreeClose" },
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("plugins-config.nvimtree")
		end,
	})
	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("plugins-config.lualine")
		end,
	})
	use({
		"ThePrimeagen/harpoon",
		config = function()
			require("plugins-config.harpoon")
		end,
		event = "BufEnter",
	})
	use({
		"ghillb/cybu.nvim",
		config = function()
			require("plugins-config.cybu")
		end,
	})
	use({
		"ggandor/leap.nvim",
		config = function()
			require("plugins-config.leap")
		end,
		keys = "s",
	})
	use({
		"xiyaowong/nvim-transparent",
		config = function()
			require("plugins-config.transparent")
		end,
	})
	use({ "szw/vim-maximizer", event = "WinEnter" })
	use({ "famiu/bufdelete.nvim", cmd = "Bdelete" })

	-- GIT -------------------------------------------------------
	use({
		"lewis6991/gitsigns.nvim",
		ft = "gitcommit",
		event = "BufEnter",
		config = function()
			require("plugins-config.gitsigns")
		end,
	})
	use({
		"sindrets/diffview.nvim",
		config = function()
			require("plugins-config.gitdiff")
		end,
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
	})

	-- EDITING ---------------------------------------------------
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("plugins-config.comment")
		end,
	})
	use({
		"windwp/nvim-autopairs",
		after = "nvim-cmp",
		config = function()
			require("plugins-config.autopairs")
		end,
	})
	use({
		"abecodes/tabout.nvim",
		event = "InsertEnter",
		config = function()
			require("plugins-config.tabout")
		end,
	})
	use({ "tversteeg/registers.nvim", event = "InsertEnter" })

	-- MINI MODULES ----------------------------------------------
	use({
		"echasnovski/mini.nvim",
		config = function()
			require("plugins-config.mini")
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
			require("plugins-config.neorg")
		end,
	})
	use({
		"itchyny/calendar.vim",
		config = function()
			require("plugins-config.calendar")
		end,
		cmd = "Calendar",
	})
	-- rm -rf ~/.cache/calendar.vim/google/

	-- FRONTEND DEVELOPMENT --------------------------------------
	use({
		"windwp/nvim-ts-autotag",
		after = "nvim-treesitter",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	})
	use({
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("plugins-config.colorizer")
		end,
	})
	use({
		"ziontee113/color-picker.nvim",
		cmd = { "PickColor", "PickColorInsert" },
		config = function()
			require("plugins-config.color-picker")
		end,
	})

	-- COLORSCHEMES ----------------------------------------------
	use({
		"lunarvim/darkplus.nvim",
		"sainnhe/gruvbox-material",
		"luisiacc/gruvbox-baby",
		"rebelot/kanagawa.nvim",
		"nxvu699134/vn-night.nvim",
		"folke/tokyonight.nvim",
		"marko-cerovac/material.nvim",
		"Tsuzat/NeoSolarized.nvim",
		"savq/melange",
		"Mofiqul/dracula.nvim",
		"sainnhe/everforest",
		"sainnhe/sonokai",
		"shaeinst/roshnivim-cs",
		-- "ray-x/aurora",
		"fenetikm/falcon",
		"yashguptaz/calvera-dark.nvim",
		"rose-pine/neovim",
		"olimorris/onedarkpro.nvim",
		"rmehri01/onenord.nvim",
		"tiagovla/tokyodark.nvim",
		"cpea2506/one_monokai.nvim",
		"sainnhe/edge",
		"B4mbus/oxocarbon-lua.nvim",
		"lmburns/kimbox",
		"ray-x/starry.nvim",
	})
	use({
		"ellisonleao/gruvbox.nvim",
		config = function()
			require("plugins-config.colorschemes").gruvbox()
		end,
	})
	use({
		"navarasu/onedark.nvim",
		config = function()
			require("plugins-config.colorschemes").onedark()
		end,
	})
	use({
		"EdenEast/nightfox.nvim",
		config = function()
			require("plugins-config.colorschemes").nightfox()
		end,
	})

	-- CODE WARS -------------------------------------------------
	-- run = "cd js && npm ci" at lab plugin dir
	use({
		"0x100101/lab.nvim",
		opt = true,
		cmd = { "Lab code run", "Lab code stop" },
		config = function()
			require("plugins-config.lab")
		end,
	})
	use({ "metakirby5/codi.vim" })

	-- GAME ------------------------------------------------------
	-- use({
	-- 	"seandewar/killersheep.nvim",
	-- 	config = function()
	-- 		require("killersheep").setup({
	-- 			gore = true, -- Enables/disables blood and gore.
	-- 			keymaps = {
	-- 				move_left = "h", -- Keymap to move cannon to the left.
	-- 				move_right = "l", -- Keymap to move cannon to the right.
	-- 				shoot = "<Space>", -- Keymap to shoot the cannon.
	-- 			},
	-- 		})
	-- 	end,
	-- })

	-- INTERESTING PLUGINS =======================================
	-- LSP -------------------------------------------------------
	-- ray-x/navigator.lua                            LSP hardcore
	-- stevearc/aerial.nvim                       LSP Diagram menu
	-- b0o/simrat39/symbols-outline.nvim     LSP Diagram menu (jsx)
	-- folke/trouble.nvim                       pretty diagnostics
	-- kevinhwang91/nvim-bqf                              quickfix

	-- TREESITTER ------------------------------------------------
	-- ziontee113/syntax-tree-surfer    TS navigator (no jsx, tsx)

	-- DEBUGGING -------------------------------------------------
	-- mfusseneger/nvim-dap
	-- sakhnik/nvim-gdb
	-- rcarriga/nvim-dap-ui
	-- Pocco81/DAPInstall.nvim
	-- Weissle/persistent-breakpoints.nvim
	-- theHamsta/nvim-dap-virtual-text
	-- ravenxrz/DAPInstall.nvim

	-- TESTING ---------------------------------------------------
	-- David-Kunz/jester
	-- klen/nvim-test
	-- nvim-neotest/neotest
	-- andythigpen/nvim-coverage
	-- mini.test
	-- is0n/jaq-nvim                         terminal test results
	-- EthanJWright/vs-tasks.nvim            terminal test results
	-- stevearc/overseer.nvim               ttr (exe cmds on save)
	-- andythigpen/nvim-coverage                          coverage

	-- GIT -------------------------------------------------------
	-- TimUntersberger/neogit                                magit
	-- ruifm/gitlinker.nvim                          add bitbucket
	-- pwntester/octo.nvim                                  git PR
	-- kdheepak/lazygit.nvim                               lazygit
	-- akinsho/git-conflict.nvim                         conflicts

	-- FRONTEND --------------------------------------------------
	-- vuki656/package-info.nvim                              node
	-- b0o/SchemaStore.nvim                            json schema
	-- gennaro-tedesco/nvim-jqx                         json index
	-- rest-nvim/rest.nvim                                 postman
	-- NTBBloodbath/rest.nvim                              postman
	-- mattn/webapi-vim                                  postman ?
	-- MunifTanjim/prettier.nvim              prettier alternative

	-- ARTIFICIAL INTELIGENCE ------------------------------------
	-- tzachar/cmp-tabnine
	-- jameshiew/nvim-magic
	-- zbirenbaum/copilot-cmp
	-- github/copilot.vim

	-- UTILS -----------------------------------------------------
	-- folke/todo-comments.nvim                       pretty notes
	-- tzachar/cmp-fuzzy-buffer                                CMP
	-- tzachar/cmp-fuzzy-path                                  CMP
	-- kylechui/nvim-surround   bug visual all line, too much maps
	-- ggandor/lightspeed.nvim                    leap alternative
	-- chentoast/marks.nvim                           visual marks
	-- rktjmp/lush.nvim                        colorscheme creator
	-- danymat/neogen          comments on files for documentation
	-- edluffy/specs.nvim        cool highlight cursor (has a bug)
	-- anuvyklack/pretty-fold.nvim           fold with percentages
	-- p00f/cphelper.nvim                          code challenges
	-- xeluxee/competitest.nvim                    code challenges
	-- wellle/targets.vim                              new motions
	-- MattesGroeger/vim-bookmarks                           marks
	-- ThePrimeagen/refactoring.nvim                   refactoring

	-- Last time checked Awesome and This-week-in-neovim
	-- (16/08/22)

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
