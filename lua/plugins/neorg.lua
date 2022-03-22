local status_ok, neorg = pcall(require, "neorg")
if not status_ok then
	return
end

neorg.setup({
	load = {
		["core.defaults"] = {}, -- Load all the default modules
		["core.keybinds"] = {
			config = {
				default_keybinds = true,
				hook = function(keybinds)
					keybinds.unmap("norg", "n", "<CR>") --core.norg.esupports.hop.hop-link
				end,
			},
		}, -- Load all the default modules
		-- ["core.norg.concealer"] = {}, -- Allows for use of icons
		-- ["core.norg.completion"] = {},
		-- ["core.gtd.base"] = {}, --Manages your tasks with Neorg using the Getting Things Done methology
		-- ["core.integrations.telescope"] = {}, -- Enable telescope module
		["core.norg.dirman"] = { --Managing directories full of .norg files
			config = {
				workspaces = {
					my_workspace = "~/neorg",
				},
			},
		},
		-- ["core.norg.esupports.metagen"] = { --module for generating metadata automatically
		-- 	config = { -- Note that this table is optional and doesn't need to be provided
		-- 		type = "none",
		-- 	},
		-- },
	},
})

-- DONT WORKING BECAUSE line 9 conf (pending)
-- local present, neorg_callbacks = pcall(require, "neorg.callbacks")
-- if not present then
-- 	return
-- end
--
-- neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
-- 	-- Map all the below keybinds only when the "norg" mode is active
-- 	keybinds.map_event_to_mode("norg", {
-- 		n = {
-- 			{ "<leader>n", "core.integrations.telescope.find_linkable" },
-- 		},
-- 		i = {
-- 			{ "<C-l>", "core.integrations.telescope.insert_link" },
-- 		},
-- 	}, {
-- 		silent = true,
-- 		noremap = true,
-- 	})
-- end)
