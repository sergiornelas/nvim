local tabout_ok, tabout = pcall(require, "tabout")
if not tabout_ok then
	return
end

tabout.setup({
	tabkey = "<c-d>",
	backwards_tabkey = "<c-a>",
	act_as_tab = false,
})
