local lualine_ok, lualine = pcall(require, "lualine")
local nvim_navic_ok, nvim_navic = pcall(require, "nvim-navic")
local grapple_ok, grapple = pcall(require, "grapple")

if not lualine_ok or not nvim_navic_ok or not grapple_ok then
	return
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "╎" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "NvimTree" },
		always_divide_middle = true,
		globalstatus = true,
		refresh = {
			statusline = 100,
		},
	},
	sections = {
		lualine_a = { "tabs" },
		lualine_b = { "searchcount", "location" },
		lualine_c = {
			{ nvim_navic.get_location, cond = nvim_navic.is_available },
		},
		lualine_x = {},
		lualine_y = { "diagnostics", "diff" },
		lualine_z = {
			{
				function()
					local key = grapple.key()
					return "[" .. key .. "]"
				end,
				cond = grapple.exists,
			},
		},
	},
	tabline = {},
	extensions = {},
})
