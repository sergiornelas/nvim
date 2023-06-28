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
			theme = "auto",
			component_separators = { left = "", right = "╎" },
			section_separators = "",
			disabled_filetypes = { "NvimTree" },
			always_divide_middle = true,
			globalstatus = true,
			refresh = {
				statusline = 100,
			},
		},
		sections = {
			lualine_a = {
				{
					"searchcount",
					color = { bg = "#4f0000", fg = "#ebdbb2" },
				},
				{
					function()
						local key = require("grapple").key()
						return "󰓹  [" .. key .. "]"
					end,
					cond = require("grapple").exists,
				},
			},
			lualine_b = { "diagnostics", { require("recorder").recordingStatus } },
			lualine_c = {
				{
					require("dr-lsp").lspCount,
					fmt = function(str)
						return str:gsub("[LSP:]", "")
					end,
				},
				{ require("dr-lsp").lspProgress },
				"navic",
			},
			lualine_x = {
				{
					require("lazy.status").updates,
					cond = require("lazy.status").has_updates,
					color = { fg = "#ff9e64" },
				},
			},
			lualine_y = { "diff" },
			lualine_z = {
				{
					"location",
				},
			},
		},
		tabline = {},
		extensions = {},
	})
end

return M
