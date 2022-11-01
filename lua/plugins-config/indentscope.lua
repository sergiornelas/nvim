local indentscope_ok, indentscope = pcall(require, "mini.indentscope")
if not indentscope_ok then
	return
end

indentscope.setup({
	draw = {
		animation = indentscope.gen_animation("none"),
	},
	mappings = {
		object_scope = "ij",
		object_scope_with_border = "o",
		goto_top = "\\r",
		goto_bottom = "",
	},
})
