---@diagnostic disable: inject-field
local lazy_map = {
	{
		"<leader>fc",
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
		"sho-87/kanagawa-paper.nvim",
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
		"craftzdog/solarized-osaka.nvim",
		keys = lazy_map,
		config = function()
			require("solarized-osaka").setup({
				on_highlights = function(hl, c)
					local prompt = "#2d3149"
					hl.TelescopeNormal = {
						bg = c.bg_dark,
						fg = c.fg_dark,
					}
					hl.TelescopeBorder = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
					hl.TelescopePromptNormal = {
						bg = prompt,
					}
					hl.TelescopePreviewTitle = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
					hl.TelescopeResultsTitle = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
				end,
			})
		end,
	},
	{
		"eldritch-theme/eldritch.nvim",
		keys = lazy_map,
		opts = {
			transparent = true,
		},
	},
}
