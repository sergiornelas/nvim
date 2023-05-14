local M = {
	{
		"nvim-neorg/neorg",
		ft = "norg",
		cmd = "Neorg",
		dependencies = { "nvim-neorg/neorg-telescope" },
		config = function()
			-- https://github.com/nvim-neorg/neorg/wiki
			local neorg_ok, neorg = pcall(require, "neorg")
			if not neorg_ok then
				return
			end

			neorg.setup({
				load = {
					["core.defaults"] = {},
					["core.keybinds"] = {
						config = {
							neorg_leader = ",",
							hook = function(keybinds)
								keybinds.remap_event(
									"norg",
									"n",
									"\\e",
									"core.integrations.treesitter.previous.heading"
								)
								keybinds.remap_event("norg", "n", "\\f", "core.integrations.treesitter.next.heading")
								keybinds.remap_event("norg", "n", "g<space>", "core.looking-glass.magnify-code-block")
								keybinds.remap_event("norg", "n", "\\v", "core.itero.next-iteration")
								keybinds.remap_event("norg", "i", "<cr>", "core.itero.next-iteration")
								keybinds.remap_event("norg", "n", ",e", "core.integrations.telescope.find_linkable") -- go to other header from current workspace
								keybinds.remap_event("norg", "n", ",l", "core.integrations.telescope.insert_file_link") -- insert file link from current workspace
								keybinds.remap_event("norg", "n", ",f", "core.integrations.telescope.search_headings") -- current file headers
								keybinds.remap_event("norg", "n", ",nf", "core.integrations.telescope.find_norg_files") -- find files in current workspace, not useful
								keybinds.remap_event("norg", "n", ",s", "core.integrations.telescope.switch_workspace") -- not useful
								keybinds.remap_event("norg", "n", ",L", "core.integrations.telescope.insert_link") -- not working
								keybinds.remap_event("norg", "n", ",z", "core.pivot.toggle-list-type") -- inverts all the other items in that list.
								keybinds.remap_event("norg", "n", ",x", "core.pivot.invert-list-type") -- inverts all the other items in that list, however respects mixed lists
							end,
							-- default_keybinds = false,
						},
					},
					["core.dirman"] = {
						config = {
							workspaces = {
								wiki = "~/notes/wiki",
								todo = "~/notes/todo",
								data = "~/notes/data",
							},
							default_workspace = "wiki",
							index = "index.norg",
							open_last_workspace = false,
						},
					},
					["core.concealer"] = {
						config = {
							dim_code_blocks = {
								conceal = true,
							},
							icon_preset = "varied",
							icons = {
								todo = {
									cancelled = {
										icon = "❌",
									},
									done = {
										icon = "✅",
									},
									on_hold = {
										icon = "⏸️",
									},
									pending = {
										icon = "🕒",
									},
									recurring = {
										icon = "🔄",
									},
									uncertain = {
										icon = "❔",
									},
									urgent = {
										icon = "⚠️",
									},
								},
							},
						},
					},
					["core.completion"] = {
						config = {
							engine = "nvim-cmp",
						},
					},
					["core.qol.toc"] = {
						config = {
							close_after_use = true,
						},
					},
					["core.integrations.telescope"] = {},
					-- needs maturity
					-- ["core.presenter"] = {
					-- 	config = {
					-- 		zen_mode = "zen-mode",
					-- 		-- breaks with truezen plugin
					-- 		-- pure ZenMode low fps
					-- 		-- zen-mode.nvim only applies on header 1
					-- 		-- zen-mode twilight no applies
					-- 	},
					-- },
				},
			})

			-- When error src/scanner.cc error happens:
			-- https://github.com/nvim-neorg/neorg/issues/74
			-- brew install gcc
			-- :checkhealth nvim_treesitter -> (OK: `cc` executable found)
			-- brew info gcc
			-- ln -s /usr/local/Cellar/gcc/<version>/bin/gcc-<version 11|12> /usr/local/bin/cc
			-- real: ln -s /usr/local/Cellar/gcc/12.2.0/bin/gcc-12 /usr/local/bin/cc
			-- tip: when you update cc/gcc, you'll have to delete the /usr/local/bin/cc file in order to create a new one.
		end,
	},
	{
		"m4xshen/smartcolumn.nvim",
		ft = "norg",
		opts = {
			colorcolumn = "123",
		},
	},
	{
		"folke/twilight.nvim",
		ft = "norg",
		config = function()
			require("twilight").setup({
				dimming = {
					alpha = 0.25,
				},
				context = 10, -- amount of lines we will try to show around the current line
				expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
					"function",
					"method",
					"table",
					"if_statement",
					"heading3", --norg
				},
				exclude = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"markdown",
				},
			})
		end,
	},
}

return M
