local M = {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
}

function M.config()
	local diffview_ok, diffview = pcall(require, "diffview")
	if not diffview_ok then
		return
	end

	local actions = require("diffview.actions")

	diffview.setup({
		key_bindings = {
			view = {
				["<c-i>"] = actions.select_next_entry,
				["<c-o>"] = actions.select_prev_entry,
				["<leader>g"] = actions.toggle_files,
				["<leader>e"] = "gt",
			},
			file_panel = {
				["l"] = actions.select_entry,
				["<c-i>"] = actions.select_next_entry,
				["<c-o>"] = actions.select_prev_entry,
				["<c-e>"] = actions.scroll_view(-0.25),
				["<c-u>"] = actions.scroll_view(-0.60),
				["<c-d>"] = actions.scroll_view(0.60),
				["<leader>g"] = actions.toggle_files,
				["<leader>e"] = "gt",
			},
			file_history_panel = {
				["l"] = actions.select_entry,
				["<c-i>"] = actions.select_next_entry,
				["<c-o>"] = actions.select_prev_entry,
				["<c-e>"] = actions.scroll_view(-0.25),
				["<c-u>"] = actions.scroll_view(-0.60),
				["<c-d>"] = actions.scroll_view(0.60),
				["<leader>g"] = actions.toggle_files,
				["<leader>e"] = "gt",
			},
		},
	})
end

return M
