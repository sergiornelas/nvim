local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local navic = require("nvim-navic")

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "NvimTree" },
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = { "filename" },
		lualine_b = { "diagnostics" },
		lualine_c = {
			{ navic.get_location, cond = navic.is_available },
		},
		lualine_x = {},
		lualine_y = { "diff" },
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
