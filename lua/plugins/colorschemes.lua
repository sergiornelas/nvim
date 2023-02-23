local lazy_map = {
	{
		"<leader>p",
		"<cmd>Telescope colorscheme theme=dropdown winblend=0<cr>",
	},
}

return {
	{
		"raddari/last-color.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local theme = require("last-color").recall() or "gruvbox"
			vim.api.nvim_exec(("colorscheme %s"):format(theme), false)
		end,
	},
	{
		"B4mbus/oxocarbon-lua.nvim",
		config = function()
			vim.g.oxocarbon_lua_transparent = true
		end,
		keys = lazy_map,
	},
	{
		"EdenEast/nightfox.nvim",
		keys = lazy_map,
		opts = {
			options = {
				transparent = true,
			},
		},
	},
	{
		"catppuccin/nvim",
		keys = lazy_map,
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
			})
		end,
	},
	{
		"cpea2506/one_monokai.nvim",
		keys = lazy_map,
		opts = {
			transparent = true,
		},
	},
	{
		"folke/tokyonight.nvim",
		keys = lazy_map,
		opts = {
			transparent = true,
		},
	},
	{
		"luisiacc/gruvbox-baby",
		keys = lazy_map,
		config = function()
			vim.g.gruvbox_baby_transparent_mode = 1
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		keys = lazy_map,
		opts = {
			transparent = true,
		},
	},
	{
		"rose-pine/neovim",
		keys = lazy_map,
		config = function()
			require("rose-pine").setup({
				disable_background = true,
			})
		end,
	},
	{
		"sainnhe/edge",
		keys = lazy_map,
	},
	{
		"sainnhe/gruvbox-material",
		keys = lazy_map,
		config = function()
			vim.g.gruvbox_material_transparent_background = 1
		end,
	},
	{
		"sainnhe/sonokai",
		keys = lazy_map,
		config = function()
			vim.g.sonokai_transparent_background = 1
		end,
	},
	{
		"sam4llis/nvim-tundra",
		keys = lazy_map,
		opts = {
			transparent_background = true,
		},
	},
	{
		"tiagovla/tokyodark.nvim",
		keys = lazy_map,
		config = function()
			vim.g.tokyodark_transparent_background = true
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		keys = lazy_map,
		config = function()
			require("gruvbox").setup({
				contrast = "hard",
				transparent_mode = true,
			})
			vim.o.background = "dark"
		end,
	},
	{
		"lmburns/kimbox",
		keys = lazy_map,
		opts = {
			toggle_style_key = "<leader>%",
			allow_italic = true,
			allow_underline = true,
			transparent = true,
		},
	},
	{
		"navarasu/onedark.nvim",
		keys = lazy_map,
		opts = {
			style = "deep",
			transparent = true,
		},
	},
	{
		"AlexvZyl/nordic.nvim",
		keys = lazy_map,
		opts = {
			transparent_bg = true,
		},
	},
}
