return {
	{
		"raddari/last-color.nvim",
		config = function()
			local theme = require("last-color").recall() or "gruvbox"
			vim.api.nvim_exec(("colorscheme %s"):format(theme), false)
		end,
	},
	{

		"B4mbus/oxocarbon-lua.nvim",
		"EdenEast/nightfox.nvim",
		"Shatur/neovim-ayu",
		"catppuccin/nvim",
		"cpea2506/one_monokai.nvim",
		"folke/tokyonight.nvim",
		"katawful/kat.nvim",
		"luisiacc/gruvbox-baby",
		"rebelot/kanagawa.nvim",
		"rose-pine/neovim",
		"sainnhe/edge",
		"sainnhe/gruvbox-material",
		"sainnhe/sonokai",
		"sam4llis/nvim-tundra",
		"tiagovla/tokyodark.nvim",
	},
	{
		"ellisonleao/gruvbox.nvim",
		config = function()
			require("gruvbox").setup({
				contrast = "hard",
			})
			vim.o.background = "dark"
		end,
	},
	{
		"lmburns/kimbox",
		config = {
			toggle_style_key = "<leader>%",
			allow_italic = true,
			allow_underline = true,
			transparent = false,
		},
	},
	{
		"navarasu/onedark.nvim",
		config = {
			style = "deep",
		},
	},
}
