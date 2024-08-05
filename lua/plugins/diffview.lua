local M = {
	"sindrets/diffview.nvim",
	keys = {
		{ "<leader>do", "<cmd>DiffviewOpen<cr>" },
		{ "<leader>dc", "<cmd>DiffviewClose<cr>" },
		{ "<leader>dt", "<cmd>DiffviewToggleFiles<cr>" },
		{ "<leader>dF", "<cmd>DiffviewFocusFiles<cr>" },
		{ "<leader>df", "<cmd>DiffviewFileHistory %<cr>" },
		{ "<leader>dp", "<cmd>DiffviewFileHistory<cr>" },
		{ "<leader>dr", "<cmd>DiffviewRefresh<cr>" },
		{ "<leader>dl", "<cmd>DiffviewLog<cr>" },
	},
}

function M.config()
	local diffview_ok, diffview = pcall(require, "diffview")
	if not diffview_ok then
		return
	end

	local actions = require("diffview.actions")

	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "DiffviewFileHistory", "DiffviewFiles" },
		callback = function()
			vim.api.nvim_buf_set_keymap(
				0,
				"n",
				"q",
				":lua vim.cmd('DiffviewClose')<CR>",
				{ noremap = true, silent = true }
			)
		end,
	})

	diffview.setup({
		key_bindings = {
			view = {
				["<c-i>"] = actions.select_next_entry,
				["<c-o>"] = actions.select_prev_entry,
				["<leader>a"] = actions.toggle_files,
			},
			file_panel = {
				["l"] = actions.select_entry,
				["<c-i>"] = actions.select_next_entry,
				["<c-o>"] = actions.select_prev_entry,
				["<c-u>"] = actions.scroll_view(-0.60),
				["<c-d>"] = actions.scroll_view(0.60),
				["<leader>a"] = actions.toggle_files,
			},
			file_history_panel = {
				["l"] = actions.select_entry,
				["<c-i>"] = actions.select_next_entry,
				["<c-o>"] = actions.select_prev_entry,
				["<c-u>"] = actions.scroll_view(-0.60),
				["<c-d>"] = actions.scroll_view(0.60),
				["<leader>a"] = actions.toggle_files,
			},
		},
	})
end

return M
