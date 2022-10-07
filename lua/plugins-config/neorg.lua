local status_ok, neorg = pcall(require, "neorg")
if not status_ok then
	return
end

neorg.setup({
	load = {
		["core.norg.concealer"] = {}, -- using icons instead of text
		["core.norg.esupports.hop"] = {},
		["core.highlights"] = {},
		["core.mode"] = {},
		["core.keybinds"] = {
			config = {
				default_keybinds = false,
				hook = function(keybinds)
					keybinds.remap_event("norg", "n", "gu", "core.norg.esupports.hop.hop-link")
				end,
			},
		},
		["core.neorgcmd"] = {},
		["core.integrations.treesitter"] = {}, -- integrate TreeSitter into Neorg
		["core.norg.esupports.indent"] = {}, -- indent Neorg documents
		-- ["core.defaults"] = {},
		-- ["core.norg.completion"] = { -- extra cmp options,
		-- 	config = {
		-- 		engine = "nvim-cmp",
		-- 	},
		-- },
		-- ["core.norg.dirman"] = { --Managing directories full of .norg files
		--     config = {
		--       workspaces = {
		--         notes = "~/notes",
		--         -- gtd = "~/notes/gtd",
		--       },
		--     },
		--   },
		-- ["external.context"] = {},
		-- ["core.gtd.base"] = {,
		-- 	config = {
		-- 		workspace = "gtd",
		-- 	}
		-- },
		-- ["core.norg.qol.toc"] = { -- Index,
		-- 	config = {
		-- 		default_toc_mode = "split",
		-- 		toc_split_placement = "right",
		-- 	},
		-- },
		-- ["core.integrations.telescope"] = {}, -- Enable telescope module
	},
})
