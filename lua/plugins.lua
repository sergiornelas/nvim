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

-- Run :LuaCacheClear each week
return packer.startup(function(use)
	-- PACKER ----------------------------------------------------
	use("wbthomason/packer.nvim")

	-- STARTUP OPTIMIZATIONS -------------------------------------
	use({
		"tweekmonster/startuptime.vim",
		cmd = "StartupTime",
	})
	use({
		"nathom/filetype.nvim", --0.8 will not be necessary anymore
		"lewis6991/impatient.nvim",
	})

	-- LSP -------------------------------------------------------
	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("lsp.handlers").setup()
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
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		-- check this plugin again when winbar is available
		config = function()
			require("plugins-config.lspsaga")
		end,
	})
	use({
		"lvimuser/lsp-inlayhints.nvim",
		config = function()
			require("lsp-inlayhints").setup()
		end,
	})
	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
		config = function()
			require("plugins-config.navic")
		end,
	})
	-- use({
	--  "ray-x/lsp_signature.nvim",
	--  config = function()
	--    require("lsp_signature").setup()
	--  end,
	--  wants = "neovim/nvim-lspconfig",
	-- })
	-- use({
	-- 	"RRethy/vim-illuminate",
	-- 	config = function()
	-- 		require("plugins-config.illuminate")
	-- 	end,
	-- })

	-- CMP -------------------------------------------------------
	use({
		"hrsh7th/nvim-cmp",
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
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-context",
		"drybalka/tree-climber.nvim",
		"p00f/nvim-ts-Rainbow",
		"JoosepAlviste/nvim-ts-context-commentstring",
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
		"rmagatti/session-lens",
		requires = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
		config = function()
			require("plugins-config.session-lens")
		end,
	})
	use({
		"nvim-telescope/telescope-frecency.nvim",
		requires = { "kkharji/sqlite.lua" },
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
		"kwkarlwang/bufjump.nvim",
		config = function()
			require("plugins-config.bufjump")
		end,
	})
	use({
		"ggandor/leap.nvim",
		config = function()
			require("plugins-config.leap")
		end,
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
		commit = "f2d5ecdd2ef472152f5ccd352bbc324109174a2f",
		config = function()
			require("plugins-config.neorg")
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
			require("plugins-config.colorizer")
		end,
	})
	use("uga-rosa/ccc.nvim")
	-- use({
	--   "ray-x/web-tools.nvim",
	-- config = function()
	-- 	require("web-tools").setup()
	-- end,
	-- })

	-- COLORSCHEMES ----------------------------------------------
	use("raddari/last-color.nvim")
	use({
		"B4mbus/oxocarbon-lua.nvim",
		"Mofiqul/dracula.nvim",
		"Tsuzat/NeoSolarized.nvim",
		"cpea2506/one_monokai.nvim",
		"fenetikm/falcon",
		"folke/tokyonight.nvim",
		"katawful/kat.nvim",
		"lmburns/kimbox",
		"luisiacc/gruvbox-baby",
		"lunarvim/darkplus.nvim",
		"marko-cerovac/material.nvim",
		"nxvu699134/vn-night.nvim",
		"olimorris/onedarkpro.nvim",
		"ray-x/aurora",
		"rebelot/kanagawa.nvim",
		"rmehri01/onenord.nvim",
		"rose-pine/neovim",
		"sainnhe/edge",
		"sainnhe/everforest",
		"sainnhe/gruvbox-material",
		"sainnhe/sonokai",
		"sam4llis/nvim-tundra",
		"savq/melange",
		"shaeinst/roshnivim-cs",
		"tiagovla/tokyodark.nvim",
		"yashguptaz/calvera-dark.nvim",
	})
	use({
		"EdenEast/nightfox.nvim",
		config = function()
			require("plugins-config.colorschemes").nightfox()
		end,
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

	-- CODE WARS -------------------------------------------------
	-- run = "cd js && npm ci" at lab plugin dir
	-- use({
	-- 	"0x100101/lab.nvim",
	-- 	opt = true,
	-- 	cmd = { "Lab code run", "Lab code stop" },
	-- 	config = function()
	-- 		require("plugins-config.lab")
	-- 	end,
	-- })
	-- use({ "metakirby5/codi.vim" })

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
	-- b0o/simrat39/symbols-outline.nvim    LSP Diagram menu (jsx)
	-- folke/trouble.nvim                       pretty diagnostics
	-- kevinhwang91/nvim-bqf                              quickfix
	-- ray-x/navigator.lua                            LSP hardcore
	-- stevearc/aerial.nvim                       LSP Diagram menu

	-- TREESITTER ------------------------------------------------
	-- ziontee113/syntax-tree-surfer                  TS navigator

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
	-- akinsho/git-conflict.nvim                         conflicts
	-- kdheepak/lazygit.nvim                               lazygit
	-- pwntester/octo.nvim                                  git PR
	-- ruifm/gitlinker.nvim                          add bitbucket

	-- FRONTEND --------------------------------------------------
	-- vuki656/package-info.nvim                              node
	-- b0o/SchemaStore.nvim                            json schema
	-- gennaro-tedesco/nvim-jqx                         json index
	-- rest-nvim/rest.nvim                                 postman
	-- NTBBloodbath/rest.nvim                              postman
	-- mattn/webapi-vim                                  postman ?
	-- MunifTanjim/prettier.nvim              prettier alternative
	-- numToStr/prettierrc.nvim               prettier alternative

	-- ARTIFICIAL INTELIGENCE ------------------------------------
	-- github/copilot.vim
	-- jameshiew/nvim-magic
	-- tzachar/cmp-tabnine
	-- zbirenbaum/copilot-cmp

	-- UTILS -----------------------------------------------------
	-- MattesGroeger/vim-bookmarks                           marks
	-- ThePrimeagen/refactoring.nvim                   refactoring
	-- anuvyklack/pretty-fold.nvim           fold with percentages
	-- chentoast/marks.nvim                           visual marks
	-- danymat/neogen          comments on files for documentation
	-- edluffy/specs.nvim        cool highlight cursor (has a bug)
	-- folke/todo-comments.nvim                       pretty notes
	-- ggandor/lightspeed.nvim                    leap alternative
	-- kylechui/nvim-surround   bug visual all line, too much maps
	-- nvim-colortils/colortils.nvim                   colorpicker
	-- p00f/cphelper.nvim                          code challenges
	-- rktjmp/lush.nvim                        colorscheme creator
	-- smartpde/neoscopes   light project magagement (interesting)
	-- tzachar/cmp-fuzzy-buffer                                CMP
	-- tzachar/cmp-fuzzy-path                                  CMP
	-- vigoux/notifier.nvim                show message lsp loaded
	-- wellle/targets.vim                              new motions
	-- xeluxee/competitest.nvim                    code challenges
	-- potamides/pantran.nvim                    google translator
	-- phaazon/mind.nvim                                  note app
	-- jghauser/kitty-runner.nvim         kitty commands from nvim

	-- Last time checked Awesome and This-week-in-neovim
	-- (12/09/22)

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
