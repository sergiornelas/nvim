local present, _ = pcall(require, "impatient")

if not present then
	return
end

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
}

require("orgmode").setup_ts_grammar()

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end

-- load options, mappings, and plugins
local modules = {
	"config",
	"options",
	"keymaps",
	"colorscheme",
	"pluginList",
}

for i = 1, #modules, 1 do
	pcall(require, modules[i])
end
