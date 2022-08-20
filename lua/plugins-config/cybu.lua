local ok, cybu = pcall(require, "cybu")
if not ok then
	return
end
cybu.setup({
	display_time = 550,
	position = {
		relative_to = "win",
		anchor = "topright",
		max_win_height = 7,
		max_win_width = 0.3,
		-- vertical_offset = "40",
		-- horizontal_offset = "15",
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

-- topleft, topcenter, topright,
-- centerleft, center, centerright,
-- bottomleft, bottomcenter, bottomright
