return {
	"brenoprata10/nvim-highlight-colors",
	cond = not vim.g.vscode,
	event = "BufReadPre",
	config = function()
		require("nvim-highlight-colors").setup({
			---Render style
			---@usage 'background'|'foreground'|'virtual'
			render = "background",
			enable_named_colors = false,
		})
	end,
}
