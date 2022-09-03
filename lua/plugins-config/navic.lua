local navic_status_ok, navic = pcall(require, "nvim-navic")
if not navic_status_ok then
	return
end

navic.setup({
	separator = " ",
})
