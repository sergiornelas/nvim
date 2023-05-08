return {
	"gcmt/taboo.vim",
	lazy = false,
	config = function()
		vim.g.taboo_renamed_tab_format = "   [%l] %m "
		vim.g.taboo_tab_format = "   %f %m "
		vim.g.taboo_modified_tab_flag = " "
	end,
}
