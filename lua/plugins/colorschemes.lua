local lazy_map = {
	{
		"<leader>p",
		"<cmd>Telescope colorscheme theme=dropdown winblend=0<cr>",
	},
}

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
		keys = lazy_map,
	},
	{
		"EdenEast/nightfox.nvim",
		keys = lazy_map,
	},
	{
		"Shatur/neovim-ayu",
		keys = lazy_map,
	},
	{
		"catppuccin/nvim",
		keys = lazy_map,
	},
	{
		"cpea2506/one_monokai.nvim",
		keys = lazy_map,
	},
	{
		"folke/tokyonight.nvim",
		keys = lazy_map,
	},
	{
		"katawful/kat.nvim",
		keys = lazy_map,
	},
	{
		"luisiacc/gruvbox-baby",
		keys = lazy_map,
	},
	{
		"rebelot/kanagawa.nvim",
		keys = lazy_map,
	},
	{
		"rose-pine/neovim",
		keys = lazy_map,
	},
	{
		"sainnhe/edge",
		keys = lazy_map,
	},
	{
		"sainnhe/gruvbox-material",
		keys = lazy_map,
	},
	{
		"sainnhe/sonokai",
		keys = lazy_map,
	},
	{
		"sam4llis/nvim-tundra",
		keys = lazy_map,
	},
	{
		"tiagovla/tokyodark.nvim",
		keys = lazy_map,
	},
	{
		"ellisonleao/gruvbox.nvim",
		keys = lazy_map,
		config = function()
			require("gruvbox").setup({
				contrast = "hard",
			})
			vim.o.background = "dark"
		end,
	},
	{
		"lmburns/kimbox",
		keys = lazy_map,
		config = {
			toggle_style_key = "<leader>%",
			allow_italic = true,
			allow_underline = true,
			transparent = false,
		},
	},
	{
		"navarasu/onedark.nvim",
		keys = lazy_map,
		config = {
			style = "deep",
		},
	},
}
