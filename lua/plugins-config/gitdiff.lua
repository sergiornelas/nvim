local status_ok, diff = pcall(require, "diffview")
if not status_ok then
	return
end

local actions = require("diffview.actions")

diff.setup({
	key_bindings = {
		view = {
			["<c-i>"] = actions.select_next_entry,
			["<c-o>"] = actions.select_prev_entry,
			["<leader>r"] = actions.toggle_files,
		},
		file_panel = {
			["l"] = actions.select_entry,
			["<c-i>"] = actions.select_next_entry,
			["<c-o>"] = actions.select_prev_entry,
			["<c-e>"] = actions.scroll_view(-0.25),
			["<leader>r"] = actions.toggle_files,
		},
		file_history_panel = {
			["l"] = actions.select_entry,
			["<c-i>"] = actions.select_next_entry,
			["<c-o>"] = actions.select_prev_entry,
			["<c-e>"] = actions.scroll_view(-0.25),
			["<leader>r"] = actions.toggle_files,
		},
	},
})
