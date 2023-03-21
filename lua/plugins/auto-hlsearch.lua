return {
	"asiryk/auto-hlsearch.nvim",
	version = "1.1.0",
	event = "BufReadPre",
	opts = {
		remap_keys = { "/", "?", "#", "n", "N" },
		create_commands = true,
	},
}
