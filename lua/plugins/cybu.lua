local ok, cybu = pcall(require, "cybu")
if not ok then
	return
end
cybu.setup({
	display_time = 750,
	position = {
		relative_to = "win",
		anchor = "bottomright",
		vertical_offset = "30",
		horizontal_offset = "5",
		max_win_height = 7,
		max_win_width = 0.3,
	},
	style = {
		border = "none",
		highlights = {
			current_buffer = "IncSearch",
		},
		hide_buffer_id = true,
	},
	behavior = { -- set behavior for different modes
		mode = {
			default = {
				switch = "immediate", -- immediate, on_close
				view = "rolling", -- paging, rolling
			},
			last_used = {
				switch = "immediate", -- immediate, on_close
				view = "paging", -- paging, rolling
			},
		},
	},
})
