local swap_split_ok, swap_split = pcall(require, "swap-split")
if not swap_split_ok then
	return
end

swap_split.setup({
	ignore_filetypes = {
		"NvimTree",
	},
})
