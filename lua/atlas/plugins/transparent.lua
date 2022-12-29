local transparent_ok, transparent = pcall(require, "transparent")
if not transparent_ok then
	return
end

transparent.setup({
	enable = true,
})
