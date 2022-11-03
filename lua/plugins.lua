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

-- Autocommand that reloads neovim whenever you save the plugins.lua file
local group = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd(
	"BufWritePost",
	{ pattern = "plugins.lua", command = "source <afile> | PackerSync", group = group }
)

-- Use a protected call so we don't error out on first use
local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
	return
end

-- Have packer use a popup window
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
			require("lsp.lsp-configs").setup()
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
			require("plugins-config.lspsaga")
		end,
	})
	use({
		"lvimuser/lsp-inlayhints.nvim",
		config = function()
			require("plugins-config.inlayhints")
		end,
	})
	use({
		"SmiteshP/nvim-navic",
		config = function()
			require("plugins-config.navic")
		end,
	})

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

	-- NAVIGATION ------------------------------------------------
	use({
		"nvim-telescope/telescope.nvim",
		run = "make",
		config = function()
			require("plugins-config.telescope")
		end,
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({
		"nvim-telescope/telescope-frecency.nvim",
		requires = { "kkharji/sqlite.lua" },
	})
	use({
		"rmagatti/auto-session",
		config = function()
			require("plugins-config.auto-session")
		end,
	})
	use({
		"rmagatti/session-lens",
		config = function()
			require("plugins-config.session-lens")
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
	use("ggandor/flit.nvim")
	use("ggandor/leap-spooky.nvim")
	use({
		"petertriho/nvim-scrollbar",
		config = function()
			require("plugins-config.nvim-scrollbar")
		end,
	})
	use({
		"b0o/incline.nvim",
		config = function()
			require("plugins-config.incline")
		end,
	})
	use({
		"xiyaowong/nvim-transparent",
		config = function()
			require("plugins-config.transparent")
		end,
	})
	use({
		"anuvyklack/windows.nvim",
		requires = "anuvyklack/middleclass",
		config = function()
			require("plugins-config.windows")
		end,
	})
	use({ "famiu/bufdelete.nvim", cmd = "Bdelete" })
	use({
		"ziontee113/neo-minimap",
		config = function()
			require("plugins-config.neo")
		end,
	})

	-- EDITING ---------------------------------------------------
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("plugins-config.comment")
		end,
	})
	use({
		"echasnovski/mini.indentscope",
		config = function()
			require("plugins-config.indentscope")
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
		"kylechui/nvim-surround",
		tag = "*",
		config = function()
			require("plugins-config.nvim-surround")
		end,
	})
	use({
		"nat-418/boole.nvim",
		config = function()
			require("plugins-config.boole")
		end,
	})
	use({
		"echasnovski/mini.trailspace",
		config = function()
			require("plugins-config.trailspace")
		end,
	})
	use({
		"narutoxy/dim.lua",
		config = function()
			require("plugins-config.dim")
		end,
	})
	use({
		"abecodes/tabout.nvim",
		event = "InsertEnter",
		config = function()
			require("plugins-config.tabout")
		end,
	})
	use({
		"tversteeg/registers.nvim",
		event = "InsertEnter",
		config = function()
			require("plugins-config.registers")
		end,
	})

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
	use({
		"uga-rosa/ccc.nvim",
		config = function()
			require("plugins-config.ccc")
		end,
	})
	use("PatschD/zippy.nvim")

	-- COLORSCHEMES ----------------------------------------------
	use("raddari/last-color.nvim")
	use("rktjmp/lush.nvim")
	use({
		"B4mbus/oxocarbon-lua.nvim",
		"Mofiqul/dracula.nvim",
		"Tsuzat/NeoSolarized.nvim",
		"catppuccin/nvim",
		"cpea2506/one_monokai.nvim",
		"fenetikm/falcon",
		"folke/tokyonight.nvim",
		"kartikp10/noctis.nvim",
		"katawful/kat.nvim",
		"kvrohit/mellow.nvim",
		"lmburns/kimbox",
		"luisiacc/gruvbox-baby",
		"lunarvim/darkplus.nvim",
		"lunarvim/horizon.nvim",
		"lunarvim/synthwave84.nvim",
		"marko-cerovac/material.nvim",
		"nxvu699134/vn-night.nvim",
		"ofirgall/ofirkai.nvim",
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

	-- NOTES -----------------------------------------------------
	use({
		"nvim-neorg/neorg",
		config = function()
			require("plugins-config.neorg")
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
	-- Lommix/godot.nvim

	-- TESTING ---------------------------------------------------
	-- David-Kunz/jester
	-- klen/nvim-test
	-- rcarriga/neotest
	-- nvim-neotest/neotest
	-- andythigpen/nvim-coverage
	-- mini.test
	-- is0n/jaq-nvim                         terminal test results
	-- EthanJWright/vs-tasks.nvim            terminal test results
	-- stevearc/overseer.nvim               ttr (exe cmds on save)
	-- andythigpen/nvim-coverage                          coverage

	-- GIT -------------------------------------------------------
	-- tpope/vim-fugitive                              most robust
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
	-- ray-x/web-tools.nvim               live server for html/css
	-- Azeirah/nvim-redux                          redux telescope
	-- AckslD/nvim-FeMaco.lua                 css server for js/ts

	-- ARTIFICIAL INTELIGENCE ------------------------------------
	-- github/copilot.vim
	-- zbirenbaum/copilot-cmp
	-- jameshiew/nvim-magic
	-- tzachar/cmp-tabnine

	-- UTILS -----------------------------------------------------
	-- MattesGroeger/vim-bookmarks                           marks
	-- ThePrimeagen/refactoring.nvim                   refactoring
	-- anuvyklack/pretty-fold.nvim           fold with percentages
	-- chentoast/marks.nvim                           visual marks
	-- danymat/neogen          comments on files for documentation
	-- edluffy/specs.nvim        cool highlight cursor (has a bug)
	-- p00f/cphelper.nvim                          code challenges
	-- smartpde/neoscopes   light project magagement (interesting)
	-- charludo/projectmgr.nvim            switch between projects
	-- phaazon/mind.nvim                                  note app
	-- folke/todo-comments.nvim                       pretty notes
	-- Ostralyan/scribe.nvim                 telescope quick notes
	-- tzachar/cmp-fuzzy-buffer                                CMP
	-- tzachar/cmp-fuzzy-path                                  CMP
	-- vigoux/notifier.nvim                show message lsp loaded
	-- xeluxee/competitest.nvim                    code challenges
	-- potamides/pantran.nvim                    google translator
	-- jghauser/kitty-runner.nvim         kitty commands from nvim
	-- Chaitanyabsprip/present.nvim       power point presentation
	-- smjonas/live-command.nvim                      live command
	-- /kiran94/s3edit.nvim                                 aws s3
	-- jrop/mongo.nvim                                     mongodb
	-- cbochs/grapple.nvim             harpoon 2 (wait for mature)
	-- folke/noice.nvim                           bunch of pop ups
	-- Weissle/easy-action       leap and return (wait for mature)

	-- Last time checked Awesome and This-week-in-neovim
	-- Check the same day as the last one in order to make sure of not forget a plugin
	-- (31/10/22)

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
