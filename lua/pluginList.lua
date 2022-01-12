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

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost pluginList.lua source <afile> | PackerSync
  augroup end
]]

local use = packer.use
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
  use {
      "nathom/filetype.nvim",
      config = function()
        vim.g.did_load_filetypes = 1
      end,
  }
  use {
    "lewis6991/impatient.nvim",
    -- after = 'filetype.nvim',
  }

  use {
    "tweekmonster/startuptime.vim",
    cmd = "StartupTime",
  }

  -- COLORSCHEMES
  use "lunarvim/darkplus.nvim"
  use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}} --heavy af
  use "rebelot/kanagawa.nvim"
  use 'nxvu699134/vn-night.nvim'
  use 'srcery-colors/srcery-vim'
  -- use 'gruvbox-community/gruvbox'
  -- use 'tomasr/molokai'
  -- use "folke/tokyonight.nvim"
  -- use 'ray-x/aurora'

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
    after = "nvim-cmp",
  }
  use {
    "hrsh7th/cmp-path",
    after = "nvim-cmp",
  }

  use {
    "hrsh7th/cmp-cmdline",
    after = "nvim-cmp",
  }
  use {
    "saadparwaiz1/cmp_luasnip",
    after = "LuaSnip",
  }
  -- LSP CMP
  use {
    "hrsh7th/cmp-nvim-lsp",
    after = "nvim-lspconfig",
    -- after = "nvim-cmp",
    -- after = {"nvim-lspconfig", "nvim-cmp"}
  }
  -- LUA CMP
  use {
    "hrsh7th/cmp-nvim-lua",
    after = "nvim-cmp",
  }
  -- DETAILED INFO CMP
  -- use {
    -- "ray-x/lsp_signature.nvim",
    -- after = "nvim-lspconfig",
    -- config = function()
    -- require("plugins.others").signature()
    -- end,
  -- }
  -- TREESITTER CMP
  -- use {
  --   "ray-x/cmp-treesitter",
  --   after = "nvim-cmp",
  -- }

  -- SNIPPETS ------------------------------------------
  use {
    "L3MON4D3/LuaSnip",
    wants = "friendly-snippets",
    after = "nvim-cmp",
  }
  use {
    "rafamadriz/friendly-snippets",
    event = "InsertEnter",
  }

  -- LSP ----------------------------------------------
  use {
    "neovim/nvim-lspconfig",
    after = "nvim-lsp-installer",
    config = function()
      require "lsp"
    end,
  }
  use {
    "williamboman/nvim-lsp-installer",
    opt = true,
    setup = function()
      require("config").packer_lazy_load "nvim-lsp-installer"
        -- reload the current file so lsp actually starts for it
        vim.defer_fn(function()
          vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
        end, 0)
      end,
    config = function()
      require "lsp"
    end,
  }

  -- NULL-LS -------------------------------------------
  use {
    'jose-elias-alvarez/null-ls.nvim',
  	module = 'lspconfig',
  	requires = { 'nvim-lua/plenary.nvim' },
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
    event = "BufRead",
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
  -- use {
  --   "windwp/nvim-ts-autotag",
  -- }

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
      require('project_nvim').setup()
    end,
  }

  -- use 'andymass/vim-matchup'

  -- JSX COMMENTS
  use {
    "JoosepAlviste/nvim-ts-context-commentstring",        --heavy plugin (0.784)
    ft = {'typescriptreact', 'javascriptreact'}
  }

  use {
    "nvim-lualine/lualine.nvim",
    config = function()
      require "plugins.lualine"
    end,
  }

  use {
    "nvim-neorg/neorg",
    setup = vim.cmd("autocmd BufRead,BufNewFile *.norg setlocal filetype=norg"),
    after = {"nvim-treesitter"},  -- you may also specify telescope
    ft = "norg",
    config = function()
      require "plugins.neorg"
    end,
    requires = "nvim-lua/plenary.nvim"
  }

  use {
    "nvim-neorg/neorg-telescope",
    -- ft = "norg",
  }

  use {
    "akinsho/bufferline.nvim",
    after = "nvim-web-devicons",
    config = function()
      require "plugins.bufferline"
    end,
  }

  -- HARD MODE
  -- use 'takac/vim-hardtime'

  -- VIMWIKI
  -- use {
  --   'vimwiki/vimwiki',
  --   opt = true,
  --   keys = '<leader>ww',
  --   -- config = function()
  --   --   require('vimwiki').setup()
  --   -- end
  -- }

  -- TWILIGHT
  -- use {
  --   "folke/twilight.nvim",
  --   cmd = {
  --     "Twilight",
  --     "TwilightEnable",
  --   },
  --   config = function()
  --     require("twilight").setup {}
  --   end,
  -- }

  -- use {
  --    "max397574/better-escape.nvim",
  --    event = "InsertEnter",
  --    config = function()
  --       require("better_escape").setup {
  --          mapping = { "jk", "jj" },
  --          clear_empty_lines = true,
  --          keys = "<Esc>",
  --       }
  --    end,
  -- }

  -- use {
  --    "akinsho/bufferline.nvim",
  --    config = function()
  --       require "plugins.bufferline"
  --    end,
  -- }

  -- use {
  --    "nvim-treesitter/playground",
  --    cmd = "TSPlayground",
  -- }

  -- use {
  --    "p00f/nvim-ts-rainbow",
  --    after = "nvim-treesitter",
  -- }

  -- LSP (and copilot
  -- use {
  --    "github/copilot.vim",
  --    event = "InsertEnter",
  -- }

  -- use {
  --    "VonHeikemen/fine-cmdline.nvim",
   --    requires = {
   --       "MunifTanjim/nui.nvim",
   --    },
   --    config = function()
   --       require("plugins.others").fineCmdline()
   --    end,
   -- }

   -- use {
   --    "VonHeikemen/searchbox.nvim",
   --    requires = {
   --       "MunifTanjim/nui.nvim",
   --    },
   --    config = function()
   --       require("plugins.others").searchbox()
   --    end,
   -- }

   -- use {
   --    "rcarriga/nvim-notify",
   --    config = function()
   --       vim.notify = require "notify"
   --       require("notify").setup {
   --          stages = "slide",
   --          timeout = 2500,
   --          minimum_width = 50,
   --          icons = {
   --             ERROR = "",
   --             WARN = "",
   --             INFO = "",
   --             DEBUG = "",
   --             TRACE = "✎",
   --          },
   --       }
   --    end,
   -- }

   -- use {
   --    "Pocco81/TrueZen.nvim",
   --    cmd = {
   --       "TZAtaraxis",
   --       "TZMinimalist",
   --       "TZFocus",
   --    },
   --    config = function()
   --       require "plugins.zenmode"
   --    end,
   -- }

   -- use {
   --    "sindrets/diffview.nvim",
   --    after = "neogit",
   -- }

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

   -- use {
   --    "nvim-orgmode/orgmode",
   --    ft = "org",
   --    setup = vim.cmd "autocmd BufRead,BufNewFile *.org setlocal filetype=org",
   --    after = { "nvim-treesitter" },
   --    config = function()
   --       require("orgmode").setup {}
   --    end,
   -- }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  -- if PACKER_BOOTSTRAP then
  --   require("packer").sync()
  -- end
end)

