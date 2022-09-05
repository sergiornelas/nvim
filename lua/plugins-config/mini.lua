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

local surround_input = require("mini.surround").gen_spec.input.treesitter
local ai_input = require("mini.ai").gen_spec.treesitter

indent.setup({
	draw = {
		animation = require("mini.indentscope").gen_animation("none"),
	},
	mappings = {
		object_scope = "ij",
		object_scope_with_border = "o",
		goto_top = "\\r",
		goto_bottom = "",
	},
})

surround.setup({
	mappings = {
		add = "me",
		delete = "mw",
		replace = "mt",
		find = "mr",
		find_left = "mR",
		highlight = "mq",
		update_n_lines = "",
		suffix_last = "l",
		suffix_next = "n",
	},
	n_lines = 1000,
	custom_surroundings = {
		["("] = { output = { left = "(", right = ")" } },
		[")"] = { output = { left = "( ", right = " )" } },
		["{"] = { output = { left = "{", right = "}" } },
		["}"] = { output = { left = "{ ", right = " }" } },
		["["] = { output = { left = "[", right = "]" } },
		["]"] = { output = { left = "[ ", right = " ]" } },
		F = { input = surround_input({ outer = "@function.outer", inner = "@function.inner" }) },
		c = { input = surround_input({ outer = "@conditional.outer", inner = "@conditional.inner" }) },
	},
	search_method = "cover_or_next",
})

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
	custom_textobjects = {
		F = ai_input({ a = "@function.outer", i = "@function.inner" }),
		c = ai_input({ a = "@conditional.outer", i = "@conditional.inner" }),
	},
})
