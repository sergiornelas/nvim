return {
	"github/copilot.vim",
	lazy = false,
	config = function()
		-- (vim: not used (but by default it's in 'cinkeys' to re-indent the current line))
		vim.keymap.set("i", "<c-f>", 'copilot#Accept("\\<CR>")', {
			expr = true,
			replace_keycodes = false,
		})
		vim.g.copilot_no_tab_map = true
		vim.keymap.set("i", "<c-g>", "<Plug>(copilot-next)")
		vim.keymap.set("i", "<c-b>", "<Plug>(copilot-previous)")
		vim.keymap.set("i", "<c-l>", "<Plug>(copilot-dismiss)")
		vim.api.nvim_set_hl(0, "CopilotSuggestion", {
			fg = "#9A6CAB",
			ctermfg = 8,
			force = true,
		})
	end,
}
