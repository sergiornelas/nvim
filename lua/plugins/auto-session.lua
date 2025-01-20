local M = {
	"rmagatti/auto-session",
	lazy = false,
	commit = "30e14d965d49ce82648003982c825d0d66e81a11", -- 22 sept (stored colorscheme in x.vim last commit working)
}

function M.config()
	require("auto-session").setup({
		lsp_stop_on_restore = false, -- managed by garbage-day.nvim
		pre_save_cmds = {
			function()
				toggle_file_in_split(false)
			end,
			close_floating_windows,
			close_all_terminals,
			"ccl",
			"lclose",
		},
		save_extra_cmds = {
			-- load last colorscheme by session
			function()
				return "colorscheme " .. vim.g.colors_name
			end,
		},
		-- post_save_cmds
		-- pre_restore_cmds
		post_restore_cmds = {
			"Grapple clear_cache",
		},
		-- pre_delete_cmds
		-- post_delete_cmds
		-- no_restore_cmds
		session_lens = {
			load_on_setup = false,
			prompt_title = "~ Teleport ~",
			theme_conf = { layout_config = { width = 0.35 }, prompt_prefix = "󱓞  " },
			mappings = {
				delete_session = { "i", "<c-x>" },
				alternate_session = { "i", "<c-k>" },
			},
			path_display = { "shorten" },
		},
	})
end

return M
