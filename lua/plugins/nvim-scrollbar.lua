local scrollbar_ok, scrollbar = pcall(require, "scrollbar")
local scroll_gitsigns_ok, scroll_gitsigns = pcall(require, "scrollbar.handlers.gitsigns")

if not scrollbar_ok or not scroll_gitsigns_ok then
	return
end

scrollbar.setup({
	handlers = {
		search = false,
		handle = true,
	},
})

scroll_gitsigns.setup()
