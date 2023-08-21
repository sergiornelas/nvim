return {
	"echasnovski/mini.operators",
	version = false,
	keys = {
		"g=",
		"gx",
		"gp",
		"gR",
		"gS",
	},
	opts = {
		-- Evaluate text and replace with output
		evaluate = {
			prefix = "g=",
		},
		-- Exchange text regions
		exchange = {
			prefix = "gx",
			-- Whether to reindent new text to match previous indent
			reindent_linewise = true,
		},
		-- Multiply (duplicate) text
		multiply = {
			prefix = "gp",
		},
		-- Replace text with register
		replace = {
			prefix = "gR",
			-- Whether to reindent new text to match previous indent
			reindent_linewise = true,
		},
		-- Sort text
		sort = {
			prefix = "gS",
		},
	},
}
