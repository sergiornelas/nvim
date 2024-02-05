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
		current_line_blame_opts = {
			delay = 400,
		},
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map({ "n", "x" }, "<c-j>", function() -- (vim: same as "j")
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gs.next_hunk()
					vim.cmd("norm ^")
				end)
				return "<Ignore>"
			end, { expr = true })

			map({ "n", "x" }, "<c-k>", function() -- (vim: not used)
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gs.prev_hunk()
					vim.cmd("norm ^")
				end)
				return "<Ignore>"
			end, { expr = true })

			-- Actions
			map("n", "<leader>s", ":Gitsigns stage_hunk<cr>")
			map("n", "<leader>r", ":Gitsigns reset_hunk<cr>")
			map("v", "<leader>s", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end)
			map("v", "<leader>r", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end)
			map("n", "<leader>gS", gs.stage_buffer)
			map("n", "<leader>gu", gs.undo_stage_hunk)
			map("n", "<leader>gR", gs.reset_buffer)
			map("n", "<leader>e", gs.preview_hunk)
			map("n", "<leader>gl", function()
				gs.blame_line({ full = true })
			end)
			map("n", "<leader>gt", gs.toggle_current_line_blame)
			map("n", "<leader>gd", gs.diffthis)
			map("n", "<leader>gD", function()
				gs.diffthis("~")
			end)
			map("n", "<leader>gg", gs.toggle_deleted)
			-- Text object
			map({ "o", "x" }, "ig", ":<c-u>Gitsigns select_hunk<cr>")
			-- Extras
			map("n", "<leader>gp", gs.preview_hunk_inline)
		end,
	})
end

return M
