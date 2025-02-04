return {
	"tzachar/highlight-undo.nvim",
	keys = { { "u" }, { "<C-r>" } },
	config = function()
		require("highlight-undo").setup({
			duration = 250,
		})
	end,
}
