local M = {
	"glepnir/lspsaga.nvim",
	cmd = "Lspsaga",
}

function M.config()
	local lspsaga_ok, lspsaga = pcall(require, "lspsaga")
	if not lspsaga_ok then
		return
	end

	lspsaga.setup({
		scroll_preview = {
			scroll_down = "<C-d>",
			scroll_up = "<C-u>",
		},
		finder = {
			vsplit = "v",
			split = "s",
		},
		definition = {
			edit = "<C-c>o",
			vsplit = "<C-c>v",
			split = "<C-c>s",
			quit = "<esc>",
			close = "q",
		},
		code_action = {
			keys = {
				quit = "<esc>",
			},
		},
		diagnostic = {
			keys = {
				quit = "<esc>",
			},
		},
		rename = {
			quit = "<esc>",
			in_select = false,
		},
		symbol_in_winbar = {
			enable = false,
		},
	})
end

return M
