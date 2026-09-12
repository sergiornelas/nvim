-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("config.options")
require("config.autocommands")
require("config.utils")
require("config.file_in_float")
require("config.keymaps")

require("lazy").setup({
	defaults = {
		lazy = true,
	},
	spec = {
		{ import = "plugins" },
	},
	git = {
		timeout = 20, -- kill processes that take more than 20 seconds
	},
	ui = {
		size = { width = 0.8, height = 0.8 },
		border = "single",
		title = " Lazy",
		browser = "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser",
		custom_keys = {
			-- Open lazygit log
			["<leader>l"] = {
				function(plugin)
					require("lazy.util").float_term({ "lazygit", "log" }, {
						cwd = plugin.dir,
					})
				end,
			},
			-- Open terminal in plugin dir
			["<leader>t"] = {
				function(plugin)
					require("lazy.util").float_term(nil, {
						cwd = plugin.dir,
					})
				end,
			},
		},
	},
	checker = {
		notify = false, -- get a notification when new updates are found
	},
	performance = {
		rtp = {
			disabled_plugins = {
				-- Only files that actually exist in $VIMRUNTIME/plugin (Neovim 0.12).
				-- lazy.nvim matches by filename, so legacy Vim entries are no-ops.
				"gzip", -- edit .gz files in place
				"matchit", -- extended % (packadd matchit); Snacks.words covers JSX/HTML tags
				"netrwPlugin", -- :Explore (packadd netrw); mini.files replaces it
				"tarPlugin", -- browse .tar archives
				"tutor", -- :Tutor
				"zipPlugin", -- browse .zip archives
				-- If lazy.nvim is ever dropped for vim.pack, this table goes away
				-- (lazy sets loadplugins = false and re-implements the loader).
				-- The native equivalent is guard variables set in init.lua:
				--   vim.g.loaded_gzip = 1
				--   vim.g.loaded_matchit = 1
				--   vim.g.loaded_netrwPlugin = 1
				--   vim.g.loaded_tarPlugin = 1
				--   vim.g.loaded_zipPlugin = 1
				--   vim.g.loaded_tutor_mode_plugin = 1 -- note: not loaded_tutor
			},
		},
	},
})

-- Default colorscheme (lazygit)
vim.cmd("colorscheme gruvbox-material")
