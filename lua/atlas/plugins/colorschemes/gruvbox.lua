local gruvbox_ok, gruvbox = pcall(require, "gruvbox")
if not gruvbox_ok then
	return
end

gruvbox.setup({
	contrast = "hard",
})

vim.api.nvim_exec([[set background=dark]], false)
