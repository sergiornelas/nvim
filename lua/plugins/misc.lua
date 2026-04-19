return {
	{
		"eandrju/cellular-automaton.nvim",
		cmd = "CellularAutomaton",
		keys = {
			{
				"<leader>\\",
				"<cmd>CellularAutomaton make_it_rain<cr>",
			},
		},
	},
	{
		"alanfortlink/animatedbg.nvim",
		config = true,
		keys = {
			{
				"<leader>F",
				"<cmd>lua require('animatedbg-nvim').play({ animation = 'fireworks' })<cr>",
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
	-- TODO:
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

	-- https://www.reddit.com/r/neovim/comments/1prctpf/integrating_snackspicker_with_vscodediffnvim_a/
	-- https://www.reddit.com/r/neovim/comments/1puo5cm/any_way_to_speed_up_typescript_lsp_startup_or/
	-- https://github.com/Avi-D-coder/whisper.nvim
}
