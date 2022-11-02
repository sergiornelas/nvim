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

leap_spooky.setup({
	affixes = {
		-- These will generate mappings for all native text objects, like:
		-- (ir|ar|iR|aR|im|am|iM|aM){obj}.
		-- Special line objects will also be added, by repeating the affixes.
		-- E.g. `yrr<leap>` and `ymm<leap>` will yank a line in the current
		-- window.
		-- You can also use 'rest' & 'move' as mnemonics.
		remote = { window = "r", cross_window = "R" },
		magnetic = { window = "m", cross_window = "M" },
	},
	-- If this option is set to true, the yanked text will automatically be pasted
	-- at the cursor position if the unnamed register is in use (and the object is
	-- "non-magnetic").
	yank_paste = false,
})
