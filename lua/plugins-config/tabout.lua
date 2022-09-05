local status_ok, tabout = pcall(require, "tabout")
if not status_ok then
	return
end

tabout.setup({
	tabkey = "<c-d>",
	backwards_tabkey = "<c-a>",
	act_as_tab = false,
})
