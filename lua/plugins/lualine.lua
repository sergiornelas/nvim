local M = {
	"nvim-lualine/lualine.nvim",
	event = "BufReadPost",
}

function M.config()
	local lualine_ok, lualine = pcall(require, "lualine")
	if not lualine_ok then
		return
	end

	lualine.setup({
		options = {
			icons_enabled = true,
			theme = "gruvbox",
			component_separators = { left = "", right = "╎" },
			section_separators = "",
			disabled_filetypes = { "NvimTree" },
			always_divide_middle = true,
			globalstatus = false,
			refresh = {
				statusline = 100,
			},
		},
		sections = {
			lualine_a = {
				{
					function()
						local key = require("grapple").key()
						return "󰓹 [" .. key .. "]"
					end,
					cond = require("grapple").exists,
					color = { bg = "#151517", fg = "#ebdbb2" },
				},
				{
					"filename",
					color = { bg = "#4f0000", fg = "#ebdbb2" },
					path = 0,
				},
			},
			lualine_b = { "diagnostics" },
			lualine_c = { "navic" },
			lualine_x = { "progress" },
			lualine_y = { "diff" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = { "filename" },
			lualine_c = {},
			lualine_x = {},
		},
		tabline = {},
		extensions = {},
	})
end

return M
