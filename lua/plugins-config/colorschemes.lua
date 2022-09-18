local M = {}

M.onedark = function()
	require("onedark").setup({
		style = "deep",
	})
end

M.nightfox = function()
	require("nightfox").setup({
		options = {
			transparent = false, -- Disable setting background
		},
	})
end

M.gruvbox = function()
	require("gruvbox").setup({
		contrast = "hard",
	})
end

return M
