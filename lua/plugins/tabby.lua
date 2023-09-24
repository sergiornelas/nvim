local theme = {
	fill = { bg = "#131313" },
	current_tab = { fg = "#ebdbb2", bg = "#403E0F", style = "bold" },
	tab = { fg = "#ebdbb2", bg = "#1D1C00" },
	win = { fg = "#ebdbb2", bg = "#434040" },
}

return {
	"nanozuki/tabby.nvim",
	event = "BufReadPost",
	-- event = "TabEnter",
	-- TabEnter, TabLeave, TabNew, TabNewEntered, TabClosed
	config = function()
		-- require("tabby.nvim").setup({})
		require("tabby.tabline").set(function(line)
			return {
				line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
					return {
						line.sep("", theme.win, theme.fill),
						win.is_current() and "" or "",
						win.buf_name(),
						line.sep("", theme.win, theme.fill),
						hl = theme.win,
						margin = " ",
					}
				end),
				line.spacer(),
				line.tabs().foreach(function(tab)
					local hl = tab.is_current() and theme.current_tab or theme.tab
					return {
						line.sep("", hl, theme.fill),
						tab.is_current() and "" or "󰆣",
						tab.name(),
						line.sep("", hl, theme.fill),
						hl = hl,
						margin = " ",
					}
				end),
				hl = theme.fill,
			}
		end)
	end,
}
