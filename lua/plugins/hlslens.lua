local hlslens_ok, hlslens = pcall(require, "scrollbar.handlers.search")
if not hlslens_ok then
	return
end

hlslens.setup({
	calm_down = true,
	nearest_only = true,
	nearest_float_when = "auto",
})
