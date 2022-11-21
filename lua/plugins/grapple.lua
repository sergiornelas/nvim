local grapple_ok, grapple = pcall(require, "grapple")
if not grapple_ok then
	return
end

grapple.setup({
	scope = "directory",
	popup_options = {
		width = 40,
		height = 7,
	},
})
