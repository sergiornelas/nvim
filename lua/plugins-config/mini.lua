local ai_ok, ai = pcall(require, "mini.ai")
if not ai_ok then
	return
end

local surround_ok, surround = pcall(require, "mini.surround")
if not surround_ok then
	return
end

local indentscope_ok, indentscope = pcall(require, "mini.indentscope")
if not indentscope_ok then
	return
end

local trailspace_ok, trailspace = pcall(require, "mini.trailspace")
if not trailspace_ok then
	return
end

local ai_input = ai.gen_spec.treesitter
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

-- remember this mappings apply to visual mode as well, so you can't map them with 'd'
local surround_input = surround.gen_spec.input.treesitter
surround.setup({
	mappings = {
		add = "sj",
		delete = "si",
		replace = "so",
		find = "sf",
		find_left = "sF",
		highlight = "sh",
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

trailspace.setup()
