local M = {
	"nvim-neorg/neorg",
	ft = "norg",
	cmd = "Neorg",
}

function M.config()
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
						keybinds.remap_event("norg", "n", "\\e", "core.integrations.treesitter.previous.heading")
						keybinds.remap_event("norg", "n", "\\f", "core.integrations.treesitter.next.heading")
						keybinds.remap_event("norg", "n", "\\c", "core.looking-glass.magnify-code-block")
						keybinds.remap_event("norg", "n", "\\v", "core.itero.next-iteration")
					end,
					-- default_keybinds = false,
				},
			},
			["core.norg.concealer"] = {
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
			["core.norg.dirman"] = {
				config = {
					workspaces = {
						work = "~/notes/work",
						home = "~/notes/home",
					},
					-- neorg basically launch with this workspace enabled by default
					default_workspace = "work",
					index = "index.norg",
					open_last_workspace = false,
				},
			},
			-- Complementary:
			["core.norg.completion"] = {
				config = {
					engine = "nvim-cmp",
				},
			},
			["core.norg.qol.toc"] = { -- Index,
				config = {
					default_toc_mode = "split",
					toc_split_placement = "right",
				},
			},
			-- ["external.context"] = {},
			-- ["core.integrations.telescope"] = {}, -- Enable telescope module
		},
	})

	-- When error src/scanner.cc error happens:
	-- https://github.com/nvim-neorg/neorg/issues/74
	-- brew install gcc
	-- :checkhealth nvim_treesitter -> (OK: `cc` executable found)
	-- brew info gcc
	-- ln -s /usr/local/Cellar/gcc/<version>/bin/gcc-<version 11|12> /usr/local/bin/cc
	-- real: ln -s /usr/local/Cellar/gcc/12.2.0/bin/gcc-12 /usr/local/bin/cc
end

return M
