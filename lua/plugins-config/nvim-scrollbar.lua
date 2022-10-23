local scrollbar_ok, scrollbar = pcall(require, "scrollbar")
if not scrollbar_ok then
	return
end

scrollbar.setup({
	handlers = {
		search = false, -- Requires hlslens to be loaded, will run require("scrollbar.handlers.search").setup() for you
	},
})
