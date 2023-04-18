return {
	{
		"ggandor/leap.nvim",
		keys = {
			{
				"s",
				"<cmd> lua require('leap').leap({ target_windows = { vim.fn.win_getid() } })<cr>",
				mode = { "n", "x" },
			},
		},
	},
	{
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
	},
	{
		"gcmt/taboo.vim",
		lazy = false,
		config = function()
			vim.g.taboo_renamed_tab_format = "   [%l] %m "
			vim.g.taboo_tab_format = "   %f %m "
			vim.g.taboo_modified_tab_flag = " "
		end,
	},
	{
		"xorid/swap-split.nvim",
		cmd = "SwapSplit",
		config = true,
	},
	{ "famiu/bufdelete.nvim", cmd = "Bdelete" },
	{
		"rhysd/clever-f.vim",
		keys = {
			{
				"f",
				mode = { "n", "x" },
			},
			{
				"F",
				mode = { "n", "x" },
			},
			{
				"t",
				mode = { "n", "x" },
			},
			{
				"T",
				mode = { "n", "x" },
			},
		},
	},
	{
		"chrisgrieser/nvim-early-retirement",
		config = true,
		event = "VeryLazy",
	},
}
