local M = {
	"SmiteshP/nvim-navic",
	cond = not vim.g.vscode,
}

function M.config()
	local nvim_navic_ok, nvim_navic = pcall(require, "nvim-navic")
	if not nvim_navic_ok then
		return
	end
	nvim_navic.setup({
		icons = {
			File = "󰈙 ",
			Module = " ",
			Namespace = "󰌗 ",
			Package = " ",
			Class = "󰌗 ",
			Method = "󰆧 ",
			Property = " ",
			Field = " ",
			Constructor = " ",
			Enum = "󰕘",
			Interface = "󰕘",
			Function = "󰊕 ",
			Variable = "󰆧 ",
			Constant = "󰏿 ",
			String = "󰀬 ",
			Number = "󰎠 ",
			Boolean = "◩ ",
			Array = "󰅪 ",
			Object = "󰅩 ",
			Key = "󰌋 ",
			Null = "󰟢 ",
			EnumMember = " ",
			Struct = "󰌗 ",
			Event = " ",
			Operator = "󰆕 ",
			TypeParameter = "󰊄 ",
		},
		highlight = true,
		separator = " > ",
	})

	local colors = {
		red = "#f37290",
		orange = "#FF8700",
		yellow = "#f7bb3b",
		green = "#afd700",
		cyan = "#36d0e0",
		blue = "#61afef",
		violet = "#CBA6F7",
		teal = "#1abc9c",
	}

	vim.api.nvim_create_augroup("NavicColors", { clear = true })
	vim.api.nvim_create_autocmd("ColorScheme", {
		group = "NavicColors",
		pattern = "*",
		callback = function()
			local highlights = {
				{ "NavicIconsArray", { fg = colors.blue } },
				{ "NavicIconsBoolean", { fg = colors.violet } },
				{ "NavicIconsClass", { fg = colors.yellow } },
				{ "NavicIconsConstant", { fg = colors.cyan } },
				{ "NavicIconsConstructor", { fg = colors.blue } },
				{ "NavicIconsEnum", { fg = colors.green } },
				{ "NavicIconsEnumMember", { fg = colors.green } },
				{ "NavicIconsEvent", { fg = colors.violet } },
				{ "NavicIconsField", { fg = colors.teal } },
				{ "NavicIconsFile", { fg = colors.cyan } },
				{ "NavicIconsFunction", { fg = colors.violet } },
				{ "NavicIconsInterface", { fg = colors.orange } },
				{ "NavicIconsKey", { fg = colors.red } },
				{ "NavicIconsMethod", { fg = colors.violet } },
				{ "NavicIconsModule", { fg = colors.blue } },
				{ "NavicIconsNamespace", { fg = colors.orange } },
				{ "NavicIconsNull", { fg = colors.red } },
				{ "NavicIconsNumber", { fg = colors.green } },
				{ "NavicIconsObject", { fg = colors.orange } },
				{ "NavicIconsOperator", { fg = colors.green } },
				{ "NavicIconsPackage", { fg = colors.violet } },
				{ "NavicIconsProperty", { fg = colors.cyan } },
				{ "NavicIconsString", { fg = colors.green } },
				{ "NavicIconsStruct", { fg = colors.violet } },
				{ "NavicIconsTypeParameter", { fg = colors.green } },
				{ "NavicIconsVariable", { fg = colors.blue } },
				{ "NavicSeparator", { fg = colors.red } },
				{ "NavicText", { fg = "#B9AB96" } },
			}
			for _, highlight in ipairs(highlights) do
				vim.api.nvim_set_hl(0, highlight[1], highlight[2])
			end
		end,
	})
end

return M
