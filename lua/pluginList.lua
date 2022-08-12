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
	use("RRethy/vim-illuminate")

	-- CMP -------------------------------------------------------
	use({
		"hrsh7th/nvim-cmp",
		-- event = "InsertEnter",
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
			require("plugins.treesitter")
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
		"RRethy/nvim-treesitter-textsubjects",
		"drybalka/tree-climber.nvim",
		after = "nvim-treesitter/nvim-treesitter",
	})

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
		event = "BufEnter",
	})
	use({
		"ghillb/cybu.nvim",
		config = function()
			require("plugins.cybu")
		end,
		event = "BufAdd",
	})
	use({
		"ggandor/leap.nvim",
		config = function()
			require("plugins.leap")
		end,
		keys = "s",
	})
	use({
		"xiyaowong/nvim-transparent",
		config = function()
			require("plugins.transparent")
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
			require("plugins.gitsigns")
		end,
	})
	use({
		"sindrets/diffview.nvim",
		config = function()
			require("plugins.gitdiff")
		end,
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
	})

	-- ENHANCERS -------------------------------------------------
	use({
		"rmagatti/auto-session",
		commit = "50f5f2eaa7ff825c7036dc3c9981ebae7584b48e",
		config = function()
			require("plugins.auto-session")
		end,
	})
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("plugins.comment")
		end,
		after = "nvim-treesitter",
	})
	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("plugins.lualine")
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
		"abecodes/tabout.nvim",
		event = "InsertEnter",
		config = function()
			require("plugins.tabout")
		end,
	})
	use({ "tversteeg/registers.nvim", event = "InsertEnter" })

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
		cmd = "Calendar",
	})
	-- rm -rf ~/.cache/calendar.vim/google/

	-- FRONTEND DEVELOPMENT --------------------------------------
	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
	})
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
		"ziontee113/color-picker.nvim",
		cmd = { "PickColor", "PickColorInsert" },
		config = function()
			require("plugins.color-picker")
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
		"ishan9299/nvim-solarized-lua",
		"savq/melange",
		"Mofiqul/dracula.nvim",
		"sainnhe/everforest",
		"sainnhe/sonokai",
		"shaeinst/roshnivim-cs",
		"ray-x/aurora",
		"fenetikm/falcon",
		"yashguptaz/calvera-dark.nvim",
		"projekt0n/github-nvim-theme",
		"rose-pine/neovim",
		"olimorris/onedarkpro.nvim",
		"rmehri01/onenord.nvim",
		"tiagovla/tokyodark.nvim",
		"cpea2506/one_monokai.nvim",
		"sainnhe/edge",
		"B4mbus/oxocarbon-lua.nvim",
		"lmburns/kimbox",
		"glepnir/zephyr-nvim",
	})
	use({
		"ellisonleao/gruvbox.nvim",
		config = function()
			require("plugins.colorschemes").gruvbox()
		end,
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

	-- CODE WARS -------------------------------------------------
	-- run = "cd js && npm ci" at lab plugin dir
	use({
		"0x100101/lab.nvim",
		opt = true,
		cmd = { "Lab code run", "Lab code stop" },
		config = function()
			require("plugins.lab")
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
	-- ray-x/navigator.lua                         -- LSP hardcore
	-- stevearc/aerial.nvim               -- left LSP Diagram menu
	-- b0o/simrat39/symbols-outline.nvim  -- left LSP Diagram menu
	-- folke/trouble.nvim                    -- pretty diagnostics
	-- kevinhwang91/nvim-bqf                           -- quickfix

	-- TREESITTER ------------------------------------------------
	-- ziontee113/syntax-tree-surfer   -- navigator for treesitter (checkthis)
	-- drybalka/tree-climber.nvim      -- supposedly better than the upper one
	-- p00f/nvim-ts-rainbow                        -- ({[]}) color
	-- m-demare/hlargs.nvim                     -- arguments color
	-- nvim-treesitter/nvim-treesitter-context -- context head bar

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
	-- is0n/jaq-nvim                      -- terminal test results
	-- EthanJWright/vs-tasks.nvim         -- terminal test results

	-- GIT -------------------------------------------------------
	-- TimUntersberger/neogit                             -- magit
	-- ruifm/gitlinker.nvim                       -- add bitbucket
	-- pwntester/octo.nvim                               -- git PR
	-- kdheepak/lazygit.nvim                            -- lazygit

	-- FRONTEND --------------------------------------------------
	-- vuki656/package-info.nvim                           -- node
	-- b0o/SchemaStore.nvim                         -- json schema
	-- gennaro-tedesco/nvim-jqx                      -- json index
	-- rest-nvim/rest.nvim                              -- postman
	-- NTBBloodbath/rest.nvim                           -- postman
	-- MunifTanjim/prettier.nvim           -- prettier alternative

	-- ARTIFICIAL INTELIGENCE ------------------------------------
	-- tzachar/cmp-tabnine
	-- jameshiew/nvim-magic
	-- zbirenbaum/copilot-cmp
	-- github/copilot.vim

	-- SESSION ---------------------------------------------------
	-- olimorris/persisted.nvim
	-- Shatur/neovim-session-manager
	-- jedrzejboczar/possession.nvim
	-- rmagatti/session-lens             -- auto-session telescope

	-- UTILS -----------------------------------------------------
	-- folke/todo-comments.nvim                    -- pretty notes
	-- tzachar/cmp-fuzzy-buffer                             -- CMP
	-- tzachar/cmp-fuzzy-path                               -- CMP
	-- kylechui/nvim-surround             -- autopairs alternative
	-- ggandor/lightspeed.nvim                 -- leap alternative
	-- chentoast/marks.nvim                        -- visual marks
	-- rktjmp/lush.nvim                     -- colorscheme creator
	-- danymat/neogen       -- comments on files for documentation
	-- edluffy/specs.nvim     -- cool highlight cursor (has a bug)
	-- anuvyklack/pretty-fold.nvim        -- fold with percentages
	-- p00f/cphelper.nvim                       -- code challenges
	-- xeluxee/competitest.nvim                 -- code challenges

	-- Last time checked https://github.com/rockerBOO/awesome-neovim
	-- (09/08/22)

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
