local grapple_ok, grapple = pcall(require, "grapple")
if not grapple_ok then
	return
end

grapple.setup({
	scope = "git",
	popup_options = {
		width = 48,
		height = 8,
	},
})
