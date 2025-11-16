local M = {
	"rmagatti/auto-session",
	lazy = false,
}

function M.config()
	local function map(mode, key, command)
		vim.keymap.set(mode, key, command, { noremap = true, silent = true })
	end

	map(
		"n",
		"<c-space><c-i>",
		"<cmd>AutoSession save<cr><cmd>AutoSession restore /Users/sergiornelas/Desktop/pn_frontend<cr>"
	)
	map("n", "<c-space><c-o>", "<cmd>AutoSession save<cr><cmd>AutoSession restore /Users/sergiornelas/notes<cr>")
	map("n", "<c-space><c-n>", "<cmd>AutoSession save<cr><cmd>AutoSession restore /Users/sergiornelas/.config/nvim<cr>")
	map("n", "<c-space><c-f>", "<cmd>AutoSession save<cr><cmd>AutoSession restore /Users/sergiornelas/.config<cr>")
	map("n", "<c-space><c-space>", "<cmd>AutoSession search<cr>")

	require("auto-session").setup({
		-- preserve_buffer_on_restore = nil, -- Function that returns true if a buffer should be preserved when restoring a session (opencode?)
		purge_after_minutes = 14400, -- delete sessions that haven't been accessed for more than 10 days
		lsp_stop_on_restore = true,
		pre_save_cmds = {
			function()
				toggle_file_in_split(false)
			end,
			close_all_terminals,
			"ccl",
			"lclose",
		},
		save_extra_cmds = {
			function()
				-- load last colorscheme by session
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
		-- pre_cwd_changed_cmds
		-- post_cwd_changed_cmds
		session_lens = {
			picker_opts = {
				preview = false,
				layout = {
					width = 0.5,
					min_width = 0.5,
					max_width = 70,
					height = 0.25,
					max_height = 15,
				},
			},
			mappings = {
				delete_session = { "i", "<c-x>" },
				alternate_session = { "i", "<c-k>" },
				copy_session = { "i", "<c-c>" },
			},
		},
	})
end

return M
