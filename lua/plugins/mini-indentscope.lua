return {
	"echasnovski/mini.indentscope",
	event = "BufReadPre",
	config = function()
		local indentscope_ok, indentscope = pcall(require, "mini.indentscope")
		if not indentscope_ok then
			return
		end

		indentscope.setup({
			draw = {
				delay = 100,
				-- animation = indentscope.gen_animation.none(),
			},
			mappings = {
				object_scope = "u",
				object_scope_with_border = "o",
				goto_top = "gi",
				goto_bottom = "gk",
			},
		})
	end,
}
