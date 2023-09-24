return {
	event = { "WinNew" },
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
				local left = require("colorful-winsep.utils").direction_have(direction.left)
				local right = require("colorful-winsep.utils").direction_have(direction.right)
				if win_n == 2 and not left and not right then
					require("colorful-winsep").NvimSeparatorDel()
				end
			end,
		})
	end,
}
