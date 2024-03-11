local M = {
	{
		"nvim-neorg/neorg",
		ft = "norg",
		cmd = "Neorg",
		keys = {
			-- you can't map: nt, nn, nl, ni, nm
			-- https://github.com/nvim-neorg/neorg/blob/main/lua/neorg/modules/core/keybinds/keybinds.lua
			{ "<leader>ne", "<c-w>s<cmd>Neorg workspace todo<cr>" },
			{ "<leader>nr", "<cmd>Neorg return<cr>" },
			{ "<leader>nw", ":Neorg workspace ", { noremap = true } },
			{ "<leader>nx", "<cmd>Neorg index<cr>" },
			{ "<leader>ng", "<cmd>Neorg toggle-concealer<cr>" },
		},
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
							neorg_leader = "<leader>n",
							hook = function(keybinds)
								keybinds.remap_event("norg", "n", "]e", "core.integrations.treesitter.next.heading")
								keybinds.remap_event("norg", "n", "[e", "core.integrations.treesitter.previous.heading")
								keybinds.remap_event("norg", "n", "g<space>", "core.looking-glass.magnify-code-block")
								keybinds.remap_event("norg", "n", "<c-'>", "core.qol.todo_items.todo.task_cycle")
								keybinds.remap_event("norg", "i", "<cr>", "core.itero.next-iteration")
								keybinds.unmap("norg", "n", "<c-space>")
								-- <leader>lt list toggle
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
							-- If true, Neorg will enable folding by default for .norg documents.
							-- You may use the inbuilt Neovim folding options like foldnestmax,
							-- foldlevelstart and others to then tune the behaviour to your liking:
							-- default true
							folds = false,
							-- When set to auto, Neorg will open all folds when opening new documents
							-- if foldlevel is 0. When set to always, Neorg will always open all folds
							-- when opening new documents. When set to never, Neorg will not do anything:
							-- default "auto"
							init_open_folds = "auto",
							icon_preset = "varied",
							icons = {
								code_block = {
									conceal = true,
								},
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
									undone = {
										icon = "×",
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
}

return M
