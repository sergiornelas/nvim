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
		prev_match = "<tab>",
		next_group = "<space>",
		prev_group = "<tab>",
		eol = "<space>",
	},
})

function Leap_bidirectional()
	require("leap").leap({ target_windows = { vim.api.nvim_get_current_win() } })
end

vim.keymap.set({ "n", "v" }, "s", Leap_bidirectional, { silent = true })
