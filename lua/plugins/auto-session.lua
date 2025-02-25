local M = {
	"sergiornelas/auto-session",
	lazy = false,
}

function M.config()
	vim.keymap.set("n", "<c-space>", "<cmd>SessionSearch<cr>", { noremap = true, silent = true })

	require("auto-session").setup({
		lsp_stop_on_restore = false, -- managed by garbage-day.nvim. Not working as expected.
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
			mappings = {
				delete_session = { "i", "<c-x>" },
				alternate_session = { "i", "<c-k>" },
				copy_session = { "i", "<c-y>" },
			},
		},
	})
end

return M
