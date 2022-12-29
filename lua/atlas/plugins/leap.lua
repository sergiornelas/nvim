local leap_ok, leap = pcall(require, "leap")
local leap_spooky_ok, leap_spooky = pcall(require, "leap-spooky")

if not leap_ok or not leap_spooky_ok then
	return
end

leap.add_default_mappings()

-- TODO: M visual mode
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
