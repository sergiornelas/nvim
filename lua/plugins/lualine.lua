local lualine_ok, lualine = pcall(require, "lualine")
local nvim_navic_ok, nvim_navic = pcall(require, "nvim-navic")

if not lualine_ok or not nvim_navic_ok then
	return
end

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
		lualine_a = { "searchcount", "tabs" },
		lualine_b = { "diff", "diagnostics" },
		lualine_c = {
			{ nvim_navic.get_location, cond = nvim_navic.is_available },
		},
		lualine_x = {},
		lualine_y = { "location", "progress" },
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
