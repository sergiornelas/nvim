local session_status_ok, session_lens = pcall(require, "session-lens")
if not session_status_ok then
	return
end

session_lens.setup({
	prompt_title = "~~Teleport~~",
	path_display = { "shorten" },
	layout_config = { width = 40 },
})
