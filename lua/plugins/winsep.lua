return {
	"nvim-zh/colorful-winsep.nvim",
	config = function()
		require("colorful-winsep").setup({
			highlight = {
				fg = "#988E8E",
			},
			no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree", "DiffviewFiles" },
			create_event = function()
				local win_n = require("colorful-winsep.utils").calculate_number_windows()
				local direction = { left = "h", right = "l", up = "k", down = "j" }
				local b = require("colorful-winsep.utils").direction_have(direction.left)
				if win_n == 2 and not b then
					require("colorful-winsep").NvimSeparatorDel()
				end
			end,
		})
	end,
	event = { "WinNew" },
}
