local lazy_map = {
	{
		"<leader>fc",
		function()
			require("snacks").picker.colorschemes({
				layout = {
					layout = {
						backdrop = false,
						width = 0.2,
						min_width = 30,
						height = 0.3,
						min_height = 25,
						box = "vertical",
						border = "single",
						title = "{title} {live} {flags}",
						title_pos = "center",
						{ win = "input", height = 1 },
						{ win = "list", border = "single" },
						{ win = "preview", title = "{preview}", height = 0.06 },
					},
				},
			})
		end,
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
		"thesimonho/kanagawa-paper.nvim",
		keys = lazy_map,
		config = function()
			require("kanagawa-paper").setup({
				transparent = true,
				overrides = function()
					return {
						NormalFloat = { bg = "none" },
						FloatBorder = { bg = "none" },
						FloatTitle = { bg = "none" },
						None = { fg = "#DACBA5" }, -- next hunk show color
					}
				end,
			})
		end,
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
			highlights = {
				["comments"] = { fg = "#0C7A8E" },
				["@comment"] = { fg = "#0C7A8E" },
				["@lsp.type.comment"] = { fg = "#0C7A8E" },
			},
		},
	},
	{
		"AlexvZyl/nordic.nvim",
		keys = lazy_map,
		opts = {
			transparent = {
				bg = true,
				float = false,
			},
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
		"craftzdog/solarized-osaka.nvim",
		keys = lazy_map,
		config = function()
			require("solarized-osaka").setup()
		end,
	},
	{
		"eldritch-theme/eldritch.nvim",
		keys = lazy_map,
		opts = {
			transparent = true,
		},
	},
	{
		"scottmckendry/cyberdream.nvim",
		keys = lazy_map,
		opts = {
			transparent = true,
		},
	},
	{
		"0xstepit/flow.nvim",
		keys = lazy_map,
		config = function()
			require("flow").setup({
				theme = {
					transparent = true,
				},
			})
		end,
	},
	{
		"ficcdaf/ashen.nvim",
		keys = lazy_map,
		opts = {
			transparent = true,
		},
	},
	{
		"everviolet/nvim",
		name = "evergarden",
		opts = {
			editor = {
				transparent_background = true,
			},
		},
	},
	{
		"datsfilipe/vesper.nvim",
		keys = lazy_map,
		opts = {
			transparent = true,
		},
	},
	{ "Mofiqul/vscode.nvim", keys = lazy_map, opts = { transparent = true } },
	{
		"cdmill/neomodern.nvim",
		keys = lazy_map,
		opts = {
			transparent = true,
		},
	},
	{
		"thallada/farout.nvim",
		keys = lazy_map,
		opts = {
			transparent = true,
		},
	},
	{
		"vague-theme/vague.nvim",
		keys = lazy_map,
		opts = {
			transparent = true,
		},
	},
	{
		"guillermodotn/nvim-earthsong",
		keys = lazy_map,
		opts = {
			styles = {
				transparency = true,
			},
		},
	},
	{
		"serhez/teide.nvim",
		keys = lazy_map,
		opts = {
			transparent = true,
		},
	},
}
