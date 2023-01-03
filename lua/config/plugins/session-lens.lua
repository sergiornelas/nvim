local M = {
	"rmagatti/session-lens",
	dependencies = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
}

function M.config()
	local session_lens_ok, session_lens = pcall(require, "session-lens")
	if not session_lens_ok then
		return
	end

	session_lens.setup({
		path_display = { "shorten" },
		prompt_title = "~~| Teleport |~~",
		layout_config = { width = 40 },
	})
end

return M
