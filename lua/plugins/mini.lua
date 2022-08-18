local ok_indent, indent = pcall(require, "mini.indentscope")
if not ok_indent then
	return
end

local ok_surround, surround = pcall(require, "mini.surround")
if not ok_surround then
	return
end

local ok_ai, ai = pcall(require, "mini.ai")
if not ok_ai then
	return
end

indent.setup({
	draw = {
		animation = require("mini.indentscope").gen_animation("none"),
	},
	mappings = {
		object_scope_with_border = "o",
		goto_top = "\\r",
		goto_bottom = "",
	},
})

surround.setup({
	mappings = {
		add = "sj",
		delete = "si",
		replace = "so",
		find = "sf",
		find_left = "sF",
		highlight = "sh",
		update_n_lines = "sn",
	},
})
-- free: ds, dq, dr, do, dm, dp, dc, du

ai.setup({
	mappings = {
		-- Main textobject prefixes
		around = "a",
		inside = "i",

		-- Next/last variants
		around_next = "an",
		inside_next = "in",
		around_last = "al",
		inside_last = "il",

		-- Move cursor to corresponding edge of `a` textobject
		goto_left = "g[",
		goto_right = "g]",
	},
})
