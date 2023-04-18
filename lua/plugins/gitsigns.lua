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

			-- Actions
			map({ "n", "v" }, "<leader>e", ":Gitsigns stage_hunk<cr>")
			map({ "n", "v" }, "<leader>jr", ":Gitsigns reset_hunk<cr>")
			map("n", "<leader>jw", gs.stage_buffer)
			map("n", "<leader>ju", gs.undo_stage_hunk)
			map("n", "<leader>jR", gs.reset_buffer)
			map("n", "<leader>g", gs.preview_hunk)
			map("n", "<leader>jb", function()
				gs.blame_line({ full = true })
			end)
			map("n", "<leader>jl", gs.toggle_current_line_blame)
			map("n", "<leader>jd", gs.diffthis)
			map("n", "<leader>jD", function()
				gs.diffthis("~")
			end)
			map("n", "<leader>jt", gs.toggle_deleted)
			-- Text object
			map({ "o", "x" }, "ig", ":<c-u>Gitsigns select_hunk<cr>")
			-- Extras
			map("n", "<leader>jh", gs.preview_hunk_inline)
			map("n", "<leader>jc", "<cmd>lua vim.lsp.buf.code_action()<cr>")
		end,
	})
end

return M
