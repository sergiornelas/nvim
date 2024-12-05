local M = {
	"rmagatti/auto-session",
	lazy = false,
}

function M.config()
	local auto_session_ok, auto_session = pcall(require, "auto-session")
	if not auto_session_ok then
		return
	end

	auto_session.setup({
		pre_save_cmds = {
			close_floating_windows,
			"ccl",
			"lclose",
			"lua toggle_file_in_split(false)",
			"RunClose",
		},
		save_extra_cmds = {
			-- load last colorscheme by session
			function()
				return "colorscheme " .. vim.g.colors_name
			end,
		},
		-- post_save_cmds
		-- pre_restore_cmds
		-- post_restore_cmds
		-- pre_delete_cmds
		-- post_delete_cmds
		-- no_restore_cmds
		session_lens = {
			load_on_setup = false,
		},
	})
end

return M
