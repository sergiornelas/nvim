local bufjump_ok, bufjump = pcall(require, "bufjump")
if not bufjump_ok then
	return
end

bufjump.setup({
	forward = "K",
	backward = "J",
})
