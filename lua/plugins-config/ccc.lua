local ccc_ok, ccc = pcall(require, "ccc")
if not ccc_ok then
	return
end

ccc.setup({
	enable = true,
})
