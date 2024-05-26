local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

---@diagnostic disable-next-line: undefined-doc-name, assign-type-mismatch
local plugins = "plugins" ---@type LazySpec

vim.g.mapleader = " "

require("config.options")
require("config.autocommands")
require("config.utils")
require("config.keymaps")

require("lazy").setup(plugins, {
	defaults = {
		lazy = true,
	},
	git = {
		timeout = 20, -- kill processes that take more than 20 seconds
	},
	ui = {
		size = { width = 0.8, height = 0.8 }, --- Disable Lazy, to stop updating plugins daily
		border = "single",
		browser = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome", -- doesn't work
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
		-- automatically check for plugin updates
		enabled = false,
		notify = false, -- get a notification when new updates are found
		frequency = 604800, -- check for updates every week
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"bugreport",
				"compiler",
				"ftplugin",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"matchit",
				"matchparen",
				"netrw",
				"netrwFileHandlers",
				"netrwPlugin",
				"netrwSettings",
				"optwin",
				"rplugin",
				"rrhelper",
				"spellfile_plugin",
				"synmenu",
				"syntax",
				"tar",
				"tarPlugin",
				"tohtml",
				"tutor",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
			},
		},
	},
})

-- Default colorscheme (lazygit)
vim.cmd("colorscheme gruvbox")
