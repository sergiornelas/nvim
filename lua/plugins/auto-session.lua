require("auto-session").setup({
	log_level = "info",
	auto_session_use_git_branch = false,
	auto_session_create_enabled = false,
	-- auto_session_create_enabled = false,
})

vim.o.sessionoptions = "blank,buffers,folds,help,tabpages,winsize,winpos,terminal"
