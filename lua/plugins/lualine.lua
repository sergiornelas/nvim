local M = {
	"nvim-lualine/lualine.nvim",
	event = "BufReadPost",
}

function M.config()
	local lualine_ok, lualine = pcall(require, "lualine")
	if not lualine_ok then
		return
	end

	local navic = require("nvim-navic")

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
				{ navic.get_location, cond = navic.is_available },
			},
			lualine_x = {
				{
					require("lazy.status").updates,
					cond = require("lazy.status").has_updates,
					color = { fg = "#ff9e64" },
				},
			},
			lualine_y = { "diagnostics", "diff" },
			lualine_z = {
				{
					function()
						local key = require("grapple").key()
						return "[" .. key .. "]"
					end,
					cond = require("grapple").exists,
				},
			},
		},
		tabline = {},
		extensions = {},
	})
end

return M
