local status_ok, neorg = pcall(require, "neorg")
if not status_ok then
	return
end

neorg.setup({
	load = {
		["core.defaults"] = {},
		["core.norg.concealer"] = {}, -- Icons
		["core.norg.dirman"] = { --Managing directories full of .norg files
			config = {
				workspaces = {
					notes = "~/notes",
					gtd = "~/notes/gtd",
				},
			},
		},
		["core.norg.qol.toc"] = { -- Index
			config = {
				default_toc_mode = "split",
				toc_split_placement = "right",
			},
		},
		["core.norg.completion"] = { --Extra cmp options
			config = {
				engine = "nvim-cmp",
			},
		},
		["core.gtd.base"] = {
			config = {
				workspace = "gtd",
			},
		}, --Manages your tasks with Neorg using the Getting Things Done methology
		-- ["core.integrations.telescope"] = {}, -- Enable telescope module
	},
})
