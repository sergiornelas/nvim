local navic_status_ok, navic = pcall(require, "nvim-navic")
if not navic_status_ok then
	return
end

navic.setup({
	highlight = true,
	separator = " ",
	icons = {
		File = " ",
		Module = " ",
		Namespace = " ",
		Package = " ",
		Class = " ",
		Method = " ",
		Property = " ",
		Field = " ",
		Constructor = " ",
		Enum = "了 ",
		Interface = " ",
		Function = " ",
		Variable = " ",
		Constant = " ",
		String = " ",
		Number = " ",
		Boolean = " ",
		Array = " ",
		Object = " ",
		Key = " ",
		Null = " ",
		EnumMember = " ",
		Struct = " ",
		Event = " ",
		Operator = " ",
		TypeParameter = " ",
	},
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

set_hl(0, "NavicIconsArray", { default = true, fg = colors.blue })
set_hl(0, "NavicIconsBoolean", { default = true, fg = colors.orange })
set_hl(0, "NavicIconsClass", { default = true, fg = colors.violet })
set_hl(0, "NavicIconsConstant", { default = true, fg = colors.cyan })
set_hl(0, "NavicIconsConstructor", { default = true, fg = colors.blue })
set_hl(0, "NavicIconsEnum", { default = true, fg = colors.green })
set_hl(0, "NavicIconsEnumMember", { default = true, fg = colors.green })
set_hl(0, "NavicIconsEvent", { default = true, fg = colors.violet })
set_hl(0, "NavicIconsField", { default = true, fg = colors.teal })
set_hl(0, "NavicIconsFile", { default = true, fg = colors.fg })
set_hl(0, "NavicIconsFunction", { default = true, fg = colors.violet })
set_hl(0, "NavicIconsInterface", { default = true, fg = colors.orange })
set_hl(0, "NavicIconsKey", { default = true, fg = colors.red })
set_hl(0, "NavicIconsMethod", { default = true, fg = colors.violet })
set_hl(0, "NavicIconsModule", { default = true, fg = colors.blue })
set_hl(0, "NavicIconsNamespace", { default = true, fg = colors.orange })
set_hl(0, "NavicIconsNull", { default = true, fg = colors.red })
set_hl(0, "NavicIconsNumber", { default = true, fg = colors.green })
set_hl(0, "NavicIconsObject", { default = true, fg = colors.orange })
set_hl(0, "NavicIconsOperator", { default = true, fg = colors.green })
set_hl(0, "NavicIconsPackage", { default = true, fg = colors.violet })
set_hl(0, "NavicIconsProperty", { default = true, fg = colors.cyan })
set_hl(0, "NavicIconsString", { default = true, fg = colors.green })
set_hl(0, "NavicIconsStruct", { default = true, fg = colors.violet })
set_hl(0, "NavicIconsTypeParameter", { default = true, fg = colors.green })
set_hl(0, "NavicIconsVariable", { default = true, fg = colors.blue })
set_hl(0, "NavicSeparator", { default = true, fg = "red" })
set_hl(0, "NavicText", { default = true, fg = "#B9AB96" })
