return {
	"supermaven-inc/supermaven-nvim",
	event = "BufRead",
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<c-f>", -- (vim: not used (but by default it's in 'cinkeys' to re-indent the current line))
				clear_suggestion = "<c-space>",
				accept_word = "<c-l>",
			},
			ignore_filetypes = { cpp = true, snacks_picker_input = true, oil = true }, -- or { "cpp", }
			color = {
				suggestion_color = "#b658cb",
				cterm = 244,
			},
			disable_inline_completion = false, -- disables inline completion for use with cmp
			disable_keymaps = false, -- disables built in keymaps for more manual control
			condition = function()
				return false
			end, -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
		})

		local function accept_line(suggestion_function)
			local line = vim.fn.line(".")
			local line_count = vim.fn.line("$")
			suggestion_function()
			local added_lines = vim.fn.line("$") - line_count
			if added_lines > 1 then
				vim.api.nvim_buf_set_lines(0, line + 1, line + added_lines, false, {})
				local last_col = #vim.api.nvim_buf_get_lines(0, line, line + 1, true)[1] or 0
				vim.api.nvim_win_set_cursor(0, { line + 1, last_col })
			end
		end

		local keymap = vim.keymap.set
		local opts = { noremap = true, silent = true }
		keymap("n", "<leader>v", "<cmd>SupermavenToggle<cr>", opts)
		keymap("i", "<c-;>", function()
			accept_line(require("supermaven-nvim.completion_preview").on_accept_suggestion)
		end, opts)
	end,
}
