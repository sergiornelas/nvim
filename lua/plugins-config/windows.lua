local windows_ok, windows = pcall(require, "windows")
if not windows_ok then
	return
end

windows.setup({
	enable = true,
})
