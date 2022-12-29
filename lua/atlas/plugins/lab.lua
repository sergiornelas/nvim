local lab_ok, lab = pcall(require, "lab")
if not lab_ok then
	return
end

lab.setup({
	code_runner = {
		enabled = true,
	},
	quick_data = {
		enabled = false,
	},
})
