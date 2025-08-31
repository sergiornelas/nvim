local M = {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPre",
	commit = "805610a9393fa231f2c2b49cb521bfa413fadb3d",
}

function M.config()
	local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
	if not gitsigns_ok then
		return
	end

	gitsigns.setup({
		current_line_blame_opts = {
			delay = 400,
		},
		-- signs_staged_enable = false, -- doesn't exist yet (commit)
		signcolumn = false,
		numhl = true,
		-- update_debounce = 0,
		on_attach = function(bufnr)
			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r)
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
			map("n", "<leader>gu", gitsigns.undo_stage_hunk)
			map("n", "<leader>gR", gitsigns.reset_buffer)
			map("n", "<leader>e", gitsigns.preview_hunk)
			map("n", "<leader>gl", function()
				gitsigns.blame_line({ full = true })
			end)
			map("n", "<leader>gt", gitsigns.toggle_current_line_blame)
			map("n", "<leader>gd", gitsigns.diffthis)
			map("n", "<leader>gD", function()
				gitsigns.diffthis("~")
			end)
			map("n", "<leader>gg", gitsigns.toggle_deleted)
			-- Text object
			map({ "o", "x" }, "ig", ":<c-u>Gitsigns select_hunk<cr>")
			-- Extras
			map("n", "<leader>ge", gitsigns.preview_hunk_inline)
		end,
	})
end

return M
