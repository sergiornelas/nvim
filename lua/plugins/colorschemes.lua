local M = {}

M.onedark = function()
	require("onedark").setup({
		toggle_style_key = "<leader>x",
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
