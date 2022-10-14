local hlslens_ok, hlslens = pcall(require, "hlslens")
if not hlslens_ok then
	return
end

hlslens.setup({
	calm_down = true,
	nearest_only = true,
	nearest_float_when = "auto",
	-- float_shadow_blend = 100,
	-- virt_priority = 0,
})

-- Update to neovim 0.8:
-- using ch=0 the last status bar (ls=3) disappears once you change the buffer.
-- Even the floating window disappears if you use ls=0, so forcefully you have to use
-- lualine with it's intermittent flash effect until this bug is fixed.
-- Remember that you have to run set ch=0 once you enter to neovim to apply the effect.
