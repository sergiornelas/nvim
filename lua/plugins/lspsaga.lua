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
			edit = "<c-c>o",
			vsplit = "<c-c>v",
			split = "<c-c>s",
			tabe = "<c-c>t",
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
				exec_action = "o",
				quit = "<esc>",
				go_action = "g",
			},
		},
		rename = {
			quit = "<esc>",
			in_select = false,
		},
		outline = {
			keys = {
				quit = "<esc>",
			},
		},
		symbol_in_winbar = {
			enable = false,
		},
		beacon = {
			enable = false,
		},
	})
end

return M
