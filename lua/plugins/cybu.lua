local ok, cybu = pcall(require, "cybu")
if not ok then
	return
end
cybu.setup({
	display_time = 750,
	position = {
		relative_to = "win",
		anchor = "bottomcenter",
		vertical_offset = "40", --desktop
		-- vertical_offset = "30", --laptop
		-- horizontal_offset = "15",
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

-- topleft, topcenter, topright,
-- centerleft, center, centerright,
-- bottomleft, bottomcenter, bottomright
