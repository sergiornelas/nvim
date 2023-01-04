local M = {
	"SmiteshP/nvim-navic",
}

function M.config()
	local nvim_navic_ok, nvim_navic = pcall(require, "nvim-navic")
	if not nvim_navic_ok then
		return
	end
	nvim_navic.setup({
		icons = {
			File = " ",
			Module = " ",
			Namespace = " ",
			Package = " ",
			Class = " ",
			Method = " ",
			Property = " ",
			Field = " ",
			Constructor = " ",
			Enum = "練",
			Interface = "練",
			Function = " ",
			Variable = " ",
			Constant = " ",
			String = " ",
			Number = " ",
			Boolean = "◩ ",
			Array = " ",
			Object = " ",
			Key = " ",
			Null = "ﳠ ",
			EnumMember = " ",
			Struct = " ",
			Event = " ",
			Operator = " ",
			TypeParameter = " ",
		},
		highlight = true,
		separator = " ",
	})

	local set_hl = vim.api.nvim_set_hl

	local colors = {
		red = "#e95678",
		orange = "#FF8700",
		yellow = "#f7bb3b",
		green = "#afd700",
		cyan = "#36d0e0",
		blue = "#61afef",
		violet = "#CBA6F7",
		teal = "#1abc9c",
	}

	set_hl(0, "NavicIconsArray", { fg = colors.blue })
	set_hl(0, "NavicIconsBoolean", { fg = colors.orange })
	set_hl(0, "NavicIconsClass", { fg = colors.violet })
	set_hl(0, "NavicIconsConstant", { fg = colors.cyan })
	set_hl(0, "NavicIconsConstructor", { fg = colors.blue })
	set_hl(0, "NavicIconsEnum", { fg = colors.green })
	set_hl(0, "NavicIconsEnumMember", { fg = colors.green })
	set_hl(0, "NavicIconsEvent", { fg = colors.violet })
	set_hl(0, "NavicIconsField", { fg = colors.teal })
	set_hl(0, "NavicIconsFile", { fg = colors.fg })
	set_hl(0, "NavicIconsFunction", { fg = colors.violet })
	set_hl(0, "NavicIconsInterface", { fg = colors.orange })
	set_hl(0, "NavicIconsKey", { fg = colors.red })
	set_hl(0, "NavicIconsMethod", { fg = colors.violet })
	set_hl(0, "NavicIconsModule", { fg = colors.blue })
	set_hl(0, "NavicIconsNamespace", { fg = colors.orange })
	set_hl(0, "NavicIconsNull", { fg = colors.red })
	set_hl(0, "NavicIconsNumber", { fg = colors.green })
	set_hl(0, "NavicIconsObject", { fg = colors.orange })
	set_hl(0, "NavicIconsOperator", { fg = colors.green })
	set_hl(0, "NavicIconsPackage", { fg = colors.violet })
	set_hl(0, "NavicIconsProperty", { fg = colors.cyan })
	set_hl(0, "NavicIconsString", { fg = colors.green })
	set_hl(0, "NavicIconsStruct", { fg = colors.violet })
	set_hl(0, "NavicIconsTypeParameter", { fg = colors.green })
	set_hl(0, "NavicIconsVariable", { fg = colors.blue })
	set_hl(0, "NavicSeparator", { fg = "red" })
	set_hl(0, "NavicText", { fg = "#B9AB96" })
end

return M
