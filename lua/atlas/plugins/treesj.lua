local treesj_ok, treesj = pcall(require, "treesj")
if not treesj_ok then
	return
end

treesj.setup({
	use_default_keymaps = false,
})
