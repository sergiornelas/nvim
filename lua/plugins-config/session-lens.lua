local session_status_ok, session_lens = pcall(require, "session-lens")
if not session_status_ok then
	return
end

session_lens.setup({
	path_display = { "shorten" },
	prompt_title = "~~| Teleport |~~",
	layout_config = { width = 40 },
})
