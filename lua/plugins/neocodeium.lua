return {
	"monkoose/neocodeium",
	event = "VeryLazy",
	config = function()
		local neocodeium = require("neocodeium")
		neocodeium.setup()
		local keymap = vim.keymap.set

		keymap("i", "<c-f>", neocodeium.accept)

		keymap("i", "<c-g><c-w>", neocodeium.accept_word)
		keymap("i", "<c-g><c-l>", neocodeium.accept_line)

		keymap("i", "<c-l>", neocodeium.clear)

		keymap("i", "<c-space>", neocodeium.cycle_or_complete)

		keymap("i", "<c-;>", function()
			require("neocodeium").cycle_or_complete(-1)
		end)

		keymap("n", "<leader>c", "<cmd>NeoCodeium chat<cr>")
	end,
}
