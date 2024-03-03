---@diagnostic disable: inject-field
local lazy_map = {
	{
		"<leader>c",
		"<cmd>Telescope colorscheme prompt_title=Colorscheme layout_config={width=50}<cr>",
	},
}

return {
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
		"loctvl842/monokai-pro.nvim",
		keys = lazy_map,
		opts = {
			transparent_background = true,
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
			background = {
				dark = "dragon",
			},
		},
	},
	{
		"rose-pine/neovim",
		keys = lazy_map,
		config = function()
			require("rose-pine").setup({
				styles = {
					transparency = true,
				},
			})
		end,
	},
	{
		"sainnhe/edge",
		keys = lazy_map,
		config = function()
			vim.g.edge_transparent_background = 1
		end,
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
		"tiagovla/tokyodark.nvim",
		keys = lazy_map,
		config = function()
			require("tokyodark").setup({
				transparent_background = true,
			})
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
	{
		"Tsuzat/NeoSolarized.nvim",
		keys = lazy_map,
	},
	{
		"ribru17/bamboo.nvim",
		keys = lazy_map,
		config = function()
			require("bamboo").setup({
				transparent = true,
			})
		end,
	},
	{
		"ramojus/mellifluous.nvim",
		keys = lazy_map,
		opts = {
			transparent_background = {
				enabled = true,
			},
		},
	},
	{
		"sekke276/dark_flat.nvim",
		keys = lazy_map,
		opts = {
			transparent = true,
		},
	},
	{
		"fynnfluegge/monet.nvim",
		name = "monet",
		keys = lazy_map,
		opts = {
			transparent_background = true,
		},
	},
}
