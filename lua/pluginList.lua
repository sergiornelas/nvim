-- -- Chris@ packer autoinstaller:
-- local fn = vim.fn
-- -- Automatically install packer
-- local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
-- if fn.empty(fn.glob(install_path)) > 0 then
--   PACKER_BOOTSTRAP = fn.system {
--     "git",
--     "clone",
--     "--depth",
--     "1",
--     "https://github.com/wbthomason/packer.nvim",
--     install_path,
--   }
--   print "Installing packer close and reopen Neovim..."
--   vim.cmd [[packadd packer.nvim]]
-- end

-- Use a protected call so we don't error out on first use
local present, packer = pcall(require, "packerInit")
if present then
   packer = require "packer"
else
   return false
end

local use = packer.use

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost pluginList.lua source <afile> | PackerSync
  augroup end
]]

-- Install your plugins here
return packer.startup(function()
  -- HAVE PACKER MANAGE ITSELF -----------------------
  use {
    "wbthomason/packer.nvim",
    event = "VimEnter",
  }

  -- ELEMENTAL ---------------------------------------
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim

  -- STARTUP OPTIMIZATIONS ---------------------------
  use "nathom/filetype.nvim"
  use "lewis6991/impatient.nvim"
  use {
    "tweekmonster/startuptime.vim",
    cmd = "StartupTime",
  }

  -- COLORSCHEMES
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  use "lunarvim/darkplus.nvim"
  use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

  -- CMP ---------------------------------------------
  use {
    "hrsh7th/nvim-cmp",
    after = "friendly-snippets",
    config = function()
      require "plugins.cmp"
    end,
  }
  use {
    "hrsh7th/cmp-buffer",
    -- after = "nvim-cmp",
  }
  use {
    "hrsh7th/cmp-path",
    -- after = "nvim-cmp",
  }

  use {
    "hrsh7th/cmp-cmdline",
    -- after = "nvim-cmp",
  }
  use {
    "saadparwaiz1/cmp_luasnip",
    after = "LuaSnip",
  }
  -- LSP CMP
  use {
    "hrsh7th/cmp-nvim-lsp",
    -- after = "nvim-cmp",
  }
  -- LUA CMP
  use {
    "hrsh7th/cmp-nvim-lua",
    -- after = "nvim-cmp",
  }
  -- DETAILED INFO CMP
  -- use {
    -- "ray-x/lsp_signature.nvim",
    -- after = "nvim-lspconfig",
    -- config = function()
    -- require("plugins.others").signature()
    -- end,
  -- }
  -- Treesitter cmp
  -- use {
  --   "ray-x/cmp-treesitter",
  --   after = "nvim-cmp",
  -- }

  -- SNIPPETS ------------------------------------------
  use {
    "L3MON4D3/LuaSnip",
    wants = "friendly-snippets",
    after = "nvim-cmp",
    config = function()
      require("plugins.others").luasnip()
    end,
  }

  use {
    "rafamadriz/friendly-snippets",
    event = "InsertEnter",
  }

  -- LSP ----------------------------------------------
  use {
    "neovim/nvim-lspconfig",
    config = function()
      -- require "plugins.lspconfig"
      require "lsp"
    end,
  }
  use {
    "williamboman/nvim-lsp-installer",
    config = function()
      require "lsp"
    end,
  }

  -- NULL-LS -------------------------------------------
  use {
    'jose-elias-alvarez/null-ls.nvim',
  	module = 'lspconfig',
  	requires = { 'nvim-lua/plenary.nvim' },
  	config = function()
  	  require('null-ls')
  	end,
  }
  use({
    'jose-elias-alvarez/nvim-lsp-ts-utils', -- LSP-TS-UTILS
    after = 'null-ls.nvim',
  })

  -- TREESITTER -----------------------------------------
  use {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require "plugins.treesitter"
    end,
    run = ":TSUpdate",
  }
  -- RAINBOW
  use {
     "p00f/nvim-ts-rainbow",
     after = "nvim-treesitter",
  }

  -- COMMENT --------------------------------------------
  use {
    "numToStr/Comment.nvim",
    -- after = "friendly-snippets",
    config = function()
      require("plugins.others").comment()
    end,
  }

  -- TELESCOPE ------------------------------------------
  use {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    requires = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        "nvim-lua/plenary.nvim",
        run = "make",
      },
    },
    config = function()
      require "plugins.telescope"
    end,
  }
  -- use "nvim-telescope/telescope-media-files.nvim"

  -- NVIM TREE ------------------------------------------
  use {
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require "plugins.nvimtree"
    end,
  }
  -- DEVICONS
  use {
    "kyazdani42/nvim-web-devicons",
  }

  -- COLORIZER ------------------------------------------
  use {
    "norcalli/nvim-colorizer.lua",
    cmd = "ColorizerToggle",
    config = function()
      require("plugins.others").colorizer()
    end,
  }

  -- GIT SIGNS -------------------------------------------
  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.gitsigns")
    end,
  }

  -- HOP --------------------------------------------------
  use {
    "phaazon/hop.nvim",
    cmd = {
      "HopWord",
      "HopLine",
      "HopChar1",
      "HopChar2",
      "HopPattern",
    },
    as = "hop",
    config = function()
      require("hop").setup()
    end,
  }

  -- AUTOPAIRS ---------------------------------------------
  use {
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.autopairs")
    end,
  }

  -- EMMET --------------------------------------------------
  use {
    "mattn/emmet-vim",
    opt = true,
    keys = '<c-c>',
    -- cmd = {'emmet-expand-abbr'}
  }

  -- AUTO CHANGE HTML & JSX TAGS ----------------------------
  use {
    "windwp/nvim-ts-autotag",
  }

  -- TERMINAL ------------------------------------------------
  use {
    "akinsho/toggleterm.nvim",
    opt = true,
    cmd = "ToggleTerm",
    config = function()
      require("plugins.toggleterm")
    end,
  }

  -- PROJECT --------------------------------------------------
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("plugins.project")
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  -- if PACKER_BOOTSTRAP then
  --   require("packer").sync()
  -- end
end)

