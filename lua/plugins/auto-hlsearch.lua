return {
	"asiryk/auto-hlsearch.nvim",
	tag = "1.0.0",
	event = "BufReadPre",
	config = function()
		require("auto-hlsearch").setup({
			remap_keys = { "/", "?", "#", "n", "N" },
			create_commands = true,
		})
	end,
}
