local M = {
	"nvim-lualine/lualine.nvim",
	event = "BufReadPost",
}

function M.config()
	local lualine_ok, lualine = pcall(require, "lualine")
	if not lualine_ok then
		return
	end

	local function custom_status()
		local status = require("codeium.virtual_text").status()
		if status.state == "idle" then
			return ""
		end
		if status.state == "waiting" then
			return "󰔟"
		end
		if status.state == "completions" and status.total > 0 then
			return string.format("%d/%d", status.current, status.total)
		end
		return " 0 "
	end

	lualine.setup({
		options = {
			icons_enabled = true,
			theme = "gruvbox",
			component_separators = { left = "", right = "╎" },
			section_separators = "",
			always_divide_middle = true,
			globalstatus = false,
			refresh = {
				statusline = 100,
			},
		},
		sections = {
			lualine_a = {
				{
					custom_status,
				},
				{
					"progress",
					color = { bg = "", fg = "#A39D9D" },
					padding = {
						right = 1,
					},
				},
				{
					function()
						return "󰛢 " .. require("grapple").name_or_index()
					end,
					cond = function()
						return package.loaded["grapple"] and require("grapple").exists()
					end,
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
			lualine_x = { "" },
			lualine_y = { "diff" },
			lualine_z = {},
		},
		inactive_sections = {
			lualine_a = { "filename" },
			lualine_c = {},
			lualine_x = {},
		},
		tabline = {},
		extensions = { "quickfix" },
	})
end

return M
