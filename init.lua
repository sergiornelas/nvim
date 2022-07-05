local status_ok, impatient = pcall(require, "impatient")
if not status_ok then
	return
end

impatient.enable_profile()

--google calendar
vim.cmd([[
  source ~/.cache/calendar.vim/credentials.vim
]])

--disable builtin plugins
local disabled_built_ins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"tar",
	"tarPlugin",
	"spellfile_plugin",
	"zip",
	"zipPlugin",
	"matchit",
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end

require("config")
require("options")
require("keymaps")
require("pluginList")
require("colorscheme")
require("calendar")
