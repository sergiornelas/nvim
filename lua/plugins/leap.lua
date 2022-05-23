local present, leap = pcall(require, "leap")

if not present then
	return
end

require("leap").setup({
	case_insensitive = true,
	-- Leaving the appropriate list empty effectively disables "smart" mode,
	-- and forces auto-jump to be on or off.
	-- safe_labels = { . . . },
	-- labels = { . . . },
	-- These keys are captured directly by the plugin at runtime.
	special_keys = {
		repeat_search = "<enter>",
		next_match = "<enter>",
		prev_match = "<tab>",
		next_group = "<space>",
		prev_group = "<tab>",
		eol = "<space>",
	},
})

-- Searching in all windows (including the current one) on the tab page:
function Leap_all_windows()
	require("leap").leap({ ["target-windows"] = vim.api.nvim_tabpage_list_wins(0) })
end

-- Bidirectional search in the current window is just a specific case of the
-- multi-window mode - set `target-windows` to a table containing the current
-- window as the only element:
function Leap_bidirectional()
	require("leap").leap({ ["target-windows"] = { vim.api.nvim_get_current_win() } })
end

-- Map them to your preferred key, like:
vim.keymap.set("n", "s", Leap_all_windows, { silent = true })
