return {
	"nvim-mini/mini.move",
	version = "*",
	keys = {
		{ "[+", mode = { "n", "x" } },
		{ "]+", mode = { "n", "x" } },
	},
	config = function()
		require("mini.move").setup({
			-- Module mappings. Use `''` (empty string) to disable one.
			mappings = {
				-- visual mode
				left = "[\\",
				right = "]\\",
				down = "]+",
				up = "[+",
				-- normal mode
				line_left = "[\\",
				line_right = "]\\",
				line_down = "]+",
				line_up = "[+",
			},
		})
	end,
}
