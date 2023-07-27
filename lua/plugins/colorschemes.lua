-- https://github.com/AstroNvim/astrotheme
local lazy_map = {
	{
		"<leader>c",
		"<cmd>Telescope colorscheme theme=dropdown winblend=0<cr>",
	},
}

return {
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
		"maxmx03/fluoromachine.nvim",
		keys = lazy_map,
		config = function()
			require("fluoromachine").setup({
				glow = true,
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
	-- wait for transparency:
	{
		"dasupradyumna/midnight.nvim",
		keys = lazy_map,
	},
	{
		"justinsgithub/oh-my-monokai.nvim",
		keys = lazy_map,
		opts = {
			transparent_background = true,
		},
	},
}
