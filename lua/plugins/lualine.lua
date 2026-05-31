local M = {
	"nvim-lualine/lualine.nvim",
	event = "BufReadPost",
}

function M.config()
	local lualine_ok, lualine = pcall(require, "lualine")
	if not lualine_ok then
		return
	end

	-- local function custom_status()
	-- 	local status = require("codeium.virtual_text").status()
	-- 	if status.state == "idle" then
	-- 		return ""
	-- 	end
	-- 	if status.state == "waiting" then
	-- 		return "󰔟"
	-- 	end
	-- 	if status.state == "completions" and status.total > 0 then
	-- 		return string.format("%d/%d", status.current, status.total)
	-- 	end
	-- 	return " 0 "
	-- end

	local function relative_dir()
		return vim.fn.expand("%:.:h")
	end

	local progress_component = {
		"progress",
		color = { bg = "", fg = "#A39D9D" },
		padding = { right = 1 },
	}

	local function grapple_component(color)
		return {
			function()
				return "󰛢 " .. require("grapple").name_or_index()
			end,
			cond = function()
				return package.loaded["grapple"] and require("grapple").exists()
			end,
			color = color,
		}
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
				-- {
				-- 	custom_status,
				-- },
				progress_component,
				grapple_component({ bg = "#151517", fg = "#ebdbb2" }),
				{
					"filename",
					color = { bg = "#4f0000", fg = "#ebdbb2" },
					path = 0,
				},
			},
			lualine_b = { "diagnostics" },
			lualine_c = { relative_dir },
			lualine_x = { "" },
			lualine_y = { "diff" },
			lualine_z = {
				{
					-- require("opencode").statusline,
				},
			},
		},
		winbar = {
			lualine_c = { "navic" },
		},
		inactive_winbar = {
			lualine_c = { "navic" },
		},
		inactive_sections = {
			lualine_a = {
				progress_component,
				grapple_component({ bg = "#151517", fg = "#A39D9D" }),
				{
					"filename",
					path = 0,
					color = { bg = "#300000", fg = "#B0A994" },
				},
			},
			lualine_c = { relative_dir },
			lualine_x = {},
		},
		tabline = {},
		extensions = { "quickfix" },
	})
end

return M
