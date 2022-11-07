local project_nvim_ok, project_nvim = pcall(require, "project_nvim")
if not project_nvim_ok then
	return
end

project_nvim.setup({
	detection_methods = { "pattern", "lsp" },
	patterns = { ".git" },
})
