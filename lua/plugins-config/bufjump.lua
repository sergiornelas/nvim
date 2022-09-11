local bufjump_status_ok, bufjump = pcall(require, "bufjump")
if not bufjump_status_ok then
	return
end

bufjump.setup({
	forward = "K",
	backward = "J",
})
