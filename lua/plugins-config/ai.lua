local ai_ok, ai = pcall(require, "mini.ai")
if not ai_ok then
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
