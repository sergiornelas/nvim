require("auto-session").setup({
	log_level = "info",
	auto_session_use_git_branch = false,
	auto_session_create_enabled = false,
	-- cwd_change_handling = { -- table: Config for handling the DirChangePre and DirChanged autocmds, can be set to nil to disable altogether
	-- 	restore_upcoming_session = true, -- boolean: restore session for upcoming cwd on cwd change. (not working as expected)
	-- 	pre_cwd_changed_hook = nil, -- function: This is called after auto_session code runs for the `DirChangedPre` autocmd
	-- 	post_cwd_changed_hook = nil, -- function: This is called after auto_session code runs for the `DirChanged` autocmd
	-- },
})

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
-- curdir definitely no.
-- sesdir doesn't work using obsession loading Session.vim in current directory, the "issue" continues.
-- omitting curdir or sesdir with Obsession not working as well.

-- vim.o.sessionoptions = "buffers,folds,help,tabpages,winsize,winpos"
