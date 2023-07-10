local M = {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
}

-- conflicts with windows.nvim
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
				["<leader>w"] = actions.toggle_files,
				["["] = "$",
			},
			file_panel = {
				["l"] = actions.select_entry,
				["<c-i>"] = actions.select_next_entry,
				["<c-o>"] = actions.select_prev_entry,
				["<c-e>"] = actions.scroll_view(-0.25),
				["<c-u>"] = actions.scroll_view(-0.60),
				["<c-d>"] = actions.scroll_view(0.60),
				["<leader>w"] = actions.toggle_files,
				["["] = "$",
			},
			file_history_panel = {
				["l"] = actions.select_entry,
				["<c-i>"] = actions.select_next_entry,
				["<c-o>"] = actions.select_prev_entry,
				["<c-e>"] = actions.scroll_view(-0.25),
				["<c-u>"] = actions.scroll_view(-0.60),
				["<c-d>"] = actions.scroll_view(0.60),
				["<leader>w"] = actions.toggle_files,
				["["] = "$",
			},
		},
	})
end

return M
