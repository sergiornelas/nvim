require("auto-session").setup({
	log_level = "info",
	auto_session_use_git_branch = false,
	auto_session_create_enabled = false,
})

vim.o.sessionoptions = "buffers,folds,help,tabpages,winsize,winpos"
-- curdir definitely no.
-- sesdir no works using obsession loading Session.vim in current directory, the "issue" continues.
-- omitting curdir or sesdir with Obsession not working as well.
