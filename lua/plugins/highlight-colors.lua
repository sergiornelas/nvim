return {
	"brenoprata10/nvim-highlight-colors",
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
