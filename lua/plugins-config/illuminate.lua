local illuminate_ok, illuminate = pcall(require, "illuminate")
if not illuminate_ok then
	return
end

illuminate.configure({
	delay = 100,
	filetypes_denylist = {
		"NvimTree",
	},
})