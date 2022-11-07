local nightfox_ok, nightfox = pcall(require, "nightfox")
if not nightfox_ok then
	return
end

nightfox.setup({
	options = {
		transparent = false, -- Disable setting background
	},
})
