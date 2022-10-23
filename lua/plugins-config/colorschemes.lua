local onedark_ok, onedark = pcall(require, "onedark")
if not onedark_ok then
	return
end

local nightfox_ok, nightfox = pcall(require, "nightfox")
if not nightfox_ok then
	return
end

local gruvbox_ok, gruvbox = pcall(require, "gruvbox")
if not gruvbox_ok then
	return
end

local M = {}

M.onedark = function()
	onedark.setup({
		style = "deep",
	})
end

M.nightfox = function()
	nightfox.setup({
		options = {
			transparent = false, -- Disable setting background
		},
	})
end

M.gruvbox = function()
	gruvbox.setup({
		contrast = "hard",
	})
	vim.api.nvim_exec([[set background=dark]], false)
end

return M
