return {
	{
		"eandrju/cellular-automaton.nvim",
		cmd = "CellularAutomaton",
		cond = not vim.g.vscode,
		keys = {
			{
				"<leader>\\",
				"<cmd>CellularAutomaton make_it_rain<cr>",
			},
		},
	},
	{
		"alanfortlink/animatedbg.nvim",
		cond = not vim.g.vscode,
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
		cond = not vim.g.vscode,
		keys = {
			{
				"<leader>`",
				"<cmd>KillKillKill<cr>",
			},
		},
	},
	-- TODO:
	-- https://github.com/Jezda1337/nvim-html-css
	-- cssls lspconfig ready?: 91cba77 feat(ccls): add vim.lsp.config support #3807 (4 days ago)
	-- Mason fix: https://github.com/LazyVim/LazyVim/issues/6039#issuecomment-2856227817
	-- update player-one properly: master_volume = 0.7, -- Set master volume to 70%
	-- typescript-go-lsp: https://www.reddit.com/r/neovim/comments/1kk63nb/typescript_go_lsp/
	-- markdown checks: https://github.com/hamidi-dev/org-list.nvim
	-- multiple keymaps actions: echasnovski/mini.nvim#mini.keymap
	-- markdown checks: https://github.com/bngarren/checkmate.nvim
	-- https://github.com/Koalhack/darcubox-nvim
	-- https://github.com/TungstnBallon/conflict.nvim
	-- https://www.reddit.com/r/neovim/comments/1l54cu9/is_there_a_way_to_add_a_border_or_other/
	-- https://www.reddit.com/r/neovim/comments/1l4nm9a/how_do_i_remove_these_titles_in_my_lsp_hovhttps://www.reddit.com/r/neovim/comments/1kzwp30/how_much_do_you_pay_for_using_your_ai_plugin/er/
	-- https://www.reddit.com/r/neovim/comments/1kzwp30/how_much_do_you_pay_for_using_your_ai_plugin/
	-- https://www.youtube.com/watch?v=IZnhl121yo0&t=1s
}
