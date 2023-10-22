local theme = {
	fill = { bg = "#131313" },
	current_tab = { fg = "#ebdbb2", bg = "#403E0F", style = "bold" },
	tab = { fg = "#ebdbb2", bg = "#1D1C00" },
	win = { fg = "#ebdbb2", bg = "#434040" },
}

local modified_symbol = ""

local function tab_modified(tab)
	local wins = require("tabby.module.api").get_tab_wins(tab)
	for _, x in pairs(wins) do
		if vim.bo[vim.api.nvim_win_get_buf(x)].modified then
			return modified_symbol
		end
	end
	return ""
end

return {
	"nanozuki/tabby.nvim",
	event = "BufReadPost",
	config = function()
		require("tabby.tabline").set(function(line)
			return {
				line.tabs().foreach(function(tab)
					local hl = tab.is_current() and theme.current_tab or theme.tab
					return {
						line.sep("", hl, theme.fill),
						tab.is_current() and " " or "󰆣 ",
						tab.name(),
						tab_modified(tab.id),
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
