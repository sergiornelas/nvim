local M = {
	"glepnir/lspsaga.nvim",
	branch = "main",
}

function M.config()
	local lspsaga_ok, lspsaga = pcall(require, "lspsaga")
	if not lspsaga_ok then
		return
	end

	lspsaga.init_lsp_saga({
		border_style = "bold",
		diagnostic_header = { " 😡 ", " 😬 ", " 👁️ ", " 🌚 " },
		move_in_saga = { prev = "<C-o>", next = "<C-i>" },
		max_preview_lines = 30,
		code_action_lightbulb = {
			enable = true,
		},
		finder_icons = {
			def = "🐔 ",
			ref = "🐤 ",
		},
		finder_action_keys = {
			open = "<c-j>",
			vsplit = "<c-v>",
			split = "<c-s>",
			tabe = "<c-k>",
			quit = "<esc>",
		},
		definition_action_keys = {
			edit = "<c-j>",
			vsplit = "<c-v>",
			split = "<c-s>",
			tabe = "<c-k>",
			quit = "<esc>",
		},
		code_action_keys = {
			quit = "<esc>",
			exec = "<c-j>",
		},
		hover_action_quit = "<esc>",
		rename_action_quit = "<esc>",
		rename_in_select = false,
		symbol_in_winbar = {
			enable = false,
		},
		show_outline = {
			jump_key = "<c-j>",
		},
		server_filetype_map = {
			typescript = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		},
	})
end

return M
