return {
	{
		"eandrju/cellular-automaton.nvim",
		cmd = "CellularAutomaton",
		keys = {
			{
				"<leader>\\<leader>",
				"<cmd>CellularAutomaton make_it_rain<cr>",
			},
		},
	},
	{
		"seandewar/killersheep.nvim",
		keys = {
			{
				"<leader>`",
				"<cmd>KillKillKill<cr>",
			},
		},
	},

	-- :Gitsigns blame

	-- Neovim 0.13 =================
	-- multi-cursor guide
	-- https://blog.olimorris.com/2026/09/02/multiple-cursors-in-neovim-0.13/
	-- https://www.reddit.com/r/neovim/comments/1x2akdv/neovim_multiline_editing_overview_multicursor/

	-- https://www.reddit.com/r/neovim/comments/1wxzihu/just_a_quick_tip_for_all_the_multicursors_new/
	-- https://www.reddit.com/r/neovim/comments/1wxo3ek/nvim_v013_multicursor_keybinds/

	-- Makes working with AI agents easier (Milestone Due by October 1, 2026
	-- https://www.youtube.com/watch?v=BgUhhFI3aAo

	-- New text objects al (All lines)/il (Inner line)
	-- https://www.youtube.com/watch?v=L5veQ3dKQU4

	-- vim.log: Neovim 0.13’s new logging API
	-- https://www.reddit.com/r/neovim/comments/1wh9tla/vimlog_neovim_013s_new_logging_api/

	-- New features for Windows, Sessions, and Buffers
	-- https://www.reddit.com/r/neovim/comments/1wk039g/neovim_013_new_features_for_windows_sessions_and/

	-- file explorer 0.13
	-- https://www.reddit.com/r/neovim/comments/1wxmb3u/do_we_still_need_a_file_explorer_plugin_in_neovim/
	-- https://www.youtube.com/watch?v=vzFKHAL89lc

	-- TODO:
	-- https://github.com/emrearmagan/atlas.nvim
	-- markdown checks: https://github.com/hamidi-dev/org-list.nvim
	-- multiple keymaps actions: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-keymap.md
	-- https://github.com/pwntester/octo.nvim (check prs from neovim)
	-- chriswritescode-dev/consolelog.nvim

	-- vim pack tutorial:
	-- https://www.reddit.com/r/neovim/comments/1rsqnjy/a_guide_to_vimpack_neovim_builtin_plugin_manager/
	-- https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack.html
	-- https://github.com/ymic9963/nvim/blob/ec04513a338761ff48aa0c87b8454e10a59fed3f/init.lua
	-- https://www.reddit.com/r/neovim/comments/1sdl9n8/finished_migrating_from_lazynvim_to_vimpack_some/
	-- https://www.reddit.com/r/neovim/comments/1sdaetq/how_to_reproduce_lazynvims_lazy_loading_of_a/
	-- https://dotfiles.substack.com/p/whats-new-in-neovim-012 (Minimal modern structure)
	-- https://fredrikaverpil.github.io/blog/2026/04/15/from-lazy.nvim-to-vim.pack/
}
