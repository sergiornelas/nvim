function _G.close_all_floating_wins()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= "" then
			vim.api.nvim_win_close(win, false)
		end
	end
end

require("auto-session").setup({
	log_level = "error",
	auto_session_create_enabled = false,
	auto_session_use_git_branch = false,
	pre_save_cmds = { _G.close_all_floating_wins, "TSContextDisable", "w" },
	-- save_extra_cmds
	-- post_save_cmds
	-- pre_restore_cmds
	post_restore_cmds = { "execute('silent !rm ~/.local/share/nvim/sessions/*x.vim')", "TSContextEnable" },
	-- pre_delete_cmds
	-- post_delete_cmds
})

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
