local status_ok, diff = pcall(require, "diffview")
if not status_ok then
	return
end

local actions = require("diffview.actions")

diff.setup({
	key_bindings = {
		file_panel = {
			["l"] = actions.select_entry,
		},
		file_history_panel = {
			["l"] = actions.select_entry,
		},
	},
})
