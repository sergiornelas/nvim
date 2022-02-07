local status_ok, neorg = pcall(require, "neorg")
if not status_ok then
	return
end

neorg.setup({
	load = {
		["core.defaults"] = {}, -- Load all the default modules
		["core.keybinds"] = {
			config = {
				default_keybinds = false,
			},
		}, -- Load all the default modules
		["core.norg.concealer"] = {}, -- Allows for use of icons
		["core.integrations.telescope"] = {}, -- Enable telescope module
		["core.norg.dirman"] = { -- Manage your directories with Neorg
			config = {
				workspaces = {
					my_workspace = "~/neorg",
				},
			},
		},
		["core.norg.esupports.metagen"] = {
			config = { -- Note that this table is optional and doesn't need to be provided
				type = "none",
			},
		},
	},
})

local neorg_callbacks = require("neorg.callbacks")
-- local present, neorg_callbacks = pcall(require, "neorg.callbacks")
-- if not present then
--   return
-- end

neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
	-- Map all the below keybinds only when the "norg" mode is active
	-- keybinds.map("norg", "n", "gt", "<cmd>echo 'Hello!'<CR>")
	-- keybinds.unmap("norg", "n", "gt")
	-- DONT WORKING BECAUSE line 9 conf
	keybinds.map_event_to_mode("norg", {
		n = { -- Bind keys in normal mode
			{ "<C-s>", "core.integrations.telescope.find_linkable" },
		},
		i = { -- Bind in insert mode
			{ "<C-l>", "core.integrations.telescope.insert_link" },
		},
	}, {
		silent = true,
		noremap = true,
	})
end)
