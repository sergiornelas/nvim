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
		signs_staged_enable = true, -- multiple colors
		signcolumn = false,
		numhl = true,
		current_line_blame = true,
		current_line_blame_opts = {
			virt_text_pos = "right_align",
			delay = 750,
		},
		current_line_blame_formatter = "<author_time:%R>, <author>",
		update_debounce = 0,
		on_attach = function(bufnr)
			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map({ "n", "x" }, "<c-j>", function() -- (vim: same as "j")
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gitsigns.nav_hunk("next")
				end
			end)

			map({ "n", "x" }, "<c-k>", function() -- (vim: not used)
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gitsigns.nav_hunk("prev")
				end
			end)

			-- Actions
			map("n", "<leader>s", gitsigns.stage_hunk)
			map("n", "<leader>r", gitsigns.reset_hunk)

			map("v", "<leader>s", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end)

			map("v", "<leader>r", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end)

			map("n", "<leader>gS", gitsigns.stage_buffer)
			map("n", "<leader>gr", gitsigns.reset_buffer)
			map("n", "<leader>e", gitsigns.preview_hunk)
			map("n", "<leader>gg", gitsigns.preview_hunk_inline)

			map("n", "<leader>gl", function()
				gitsigns.blame_line({ full = true })
			end)

			map("n", "<leader>gd", gitsigns.diffthis)

			map("n", "<leader>gD", function()
				gitsigns.diffthis("~")
			end)

			map("n", "<leader>gA", function()
				gitsigns.setqflist("all")
			end)
			map("n", "<leader>gQ", gitsigns.setqflist)

			-- Toggles
			map("n", "<leader>gt", gitsigns.toggle_current_line_blame)
			map("n", "<leader>gw", gitsigns.toggle_word_diff)

			-- Text object
			map({ "o", "x" }, "ig", gitsigns.select_hunk)

			-- Custom stage hunk current paragraph
			map("n", "<leader><c-s>", function()
				vim.cmd("normal! mzvip")
				local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
				vim.api.nvim_feedkeys(esc, "x", false)
				local line1 = vim.fn.line("'<")
				local line2 = vim.fn.line("'>")
				gitsigns.stage_hunk({ line1, line2 })
				vim.cmd("normal! `z")
			end)
		end,
	})
end

return M
