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
		log_level = "error",
		auto_session_create_enabled = false,
		auto_session_use_git_branch = false,
		pre_save_cmds = { "lua require('incline').disable()" },
		save_extra_cmds = {
			-- load last colorscheme by session
			function()
				return "colorscheme " .. vim.g.colors_name
			end,
		},
		-- post_save_cmds
		-- pre_restore_cmds
		post_restore_cmds = { "lua require('incline').enable()" },
		-- pre_delete_cmds
		-- post_delete_cmds
		session_lens = {
			prompt_title = "~ Teleport ~",
			theme_conf = { layout_config = { width = 0.35 }, prompt_prefix = "󱓞  " },
			path_display = { "shorten" },
		},
	})

	vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,globals"
end

return M
