local ok, cybu = pcall(require, "cybu")
if not ok then
	return
end

cybu.setup({
	display_time = 700,
	position = {
		relative_to = "win",
		anchor = "bottomright",
		max_win_height = 7,
		max_win_width = 0.4,
		vertical_offset = "30",
		horizontal_offset = "13",
	},
	style = {
		path = "tail",
		border = "none",
		highlights = {
			current_buffer = "Visual",
			-- background = "MatchParen",
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
