local leap_ok, leap = pcall(require, "leap")
if not leap_ok then
	return
end

local flit_ok, flit = pcall(require, "flit")
if not flit_ok then
	return
end

local leap_spooky_ok, leap_spooky = pcall(require, "leap-spooky")
if not leap_spooky_ok then
	return
end

leap.add_default_mappings()

flit.setup({
	keys = { f = "f", F = "F", t = "t", T = "T" },
	-- A string like "nv", "nvo", "o", etc.
	labeled_modes = "v",
	multiline = true,
	-- Like `leap`s similar argument (call-specific overrides).
	-- E.g.: opts = { equivalence_classes = {} }
	opts = {},
})

leap_spooky.add_spooky_mappings({
	-- The yanked text will automatically be pasted at the cursor position
	-- if the unnamed register is in  (Experimental feature - I'm thinking
	-- about the proper API for this.)
	yank_paste = false,
	keys = {
		-- For each search scope, define a table like below, with separate affixes
		-- corresponding to "inner" and "around" objects.
		-- These will generate mappings for all given text objects, like:
		-- r{obj}, ar{obj}, R{obj}, aR{obj}, etc.
		-- Mnemonics: "remote object", "around remote object".
		window = { i = "r", a = "ar" },
		cross_window = { i = "R", a = "aR" },
		forward = nil,
		backward = nil,
	},
	textobjects = {
		"iw",
		"iW",
		"is",
		"ip",
		"i[",
		"i]",
		"i(",
		"i)",
		"ib",
		"i>",
		"i<",
		"it",
		"i{",
		"i}",
		"iB",
		'i"',
		"i'",
		"i`",
		"aw",
		"aW",
		"as",
		"ap",
		"a[",
		"a]",
		"a(",
		"a)",
		"ab",
		"a>",
		"a<",
		"at",
		"a{",
		"a}",
		"aB",
		'a"',
		"a'",
		"a`",
	},
	-- Call-specific overrides for the Leap motion itself.
	-- E.g.: opts = { equivalence_classes = {} }
	opts = nil,
})
