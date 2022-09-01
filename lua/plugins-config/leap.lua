local present, _ = pcall(require, "leap")

if not present then
	return
end

require("leap").setup({
	case_sensitive = false,
	-- safe_labels = { . . . },
	-- labels = { . . . },
	special_keys = {
		repeat_search = "<enter>",
		next_match = "<enter>",
		prev_match = "<c-i>",
		next_group = "<space>",
		prev_group = "<c-i>",
		eol = "<space>",
	},
})

function Leap_bidirectional()
	require("leap").leap({ target_windows = { vim.api.nvim_get_current_win() } })
end

vim.keymap.set({ "n", "x", "o" }, "s", Leap_bidirectional, { silent = true })
