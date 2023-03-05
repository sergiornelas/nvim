local M = {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPre",
}

function M.config()
	local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
	if not gitsigns_ok then
		return
	end

	gitsigns.setup({
		signs = {
			add = { hl = "GitSignsAdd", text = " ▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
			change = { hl = "GitSignsChange", text = " ▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
			delete = { hl = "GitSignsDelete", text = " ", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
			topdelete = {
				hl = "GitSignsDelete",
				text = " ",
				numhl = "GitSignsDeleteNr",
				linehl = "GitSignsDeleteLn",
			},
			changedelete = {
				hl = "GitSignsChange",
				text = " ~",
				numhl = "GitSignsChangeNr",
				linehl = "GitSignsChangeLn",
			},
		},
		signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
		numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
		linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
		word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
		watch_gitdir = {
			interval = 1000,
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 1000,
			ignore_whitespace = false,
		},
		current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil, -- Use default
		max_file_length = 40000,
		preview_config = {
			-- Options passed to nvim_open_win
			border = "single",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
		yadm = {
			enable = false,
		},
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "<c-g>", function()
				if vim.wo.diff then
					return "<c-g>"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, { expr = true })

			map("n", "<c-t>", function()
				if vim.wo.diff then
					return "<c-t>"
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, { expr = true })

			-- Actions
			map({ "n", "v" }, "<leader>jw", ":Gitsigns stage_hunk<cr>")
			map({ "n", "v" }, "<leader>jr", ":Gitsigns reset_hunk<cr>")
			map("n", "<leader>jW", gs.stage_buffer)
			map("n", "<leader>ju", gs.undo_stage_hunk)
			map("n", "<leader>jR", gs.reset_buffer)
			map("n", "<leader>g", gs.preview_hunk)
			map("n", "<leader>jj", function()
				gs.blame_line({ full = true })
			end)
			map("n", "<leader>jk", gs.toggle_current_line_blame)
			map("n", "<leader>jd", gs.diffthis)
			map("n", "<leader>jD", function()
				gs.diffthis("~")
			end)
			map("n", "<leader>je", gs.toggle_deleted)
			map("n", "<leader>ja", gs.preview_hunk_inline)

			-- Text object
			map({ "o", "x" }, "ih", ":<c-u>Gitsigns select_hunk<cr>")
		end,
	})
end

return M
