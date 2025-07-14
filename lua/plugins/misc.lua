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
	-- typescript-go-lsp: https://www.reddit.com/r/neovim/comments/1kk63nb/typescript_go_lsp/
	-- markdown checks: https://github.com/hamidi-dev/org-list.nvim
	-- multiple keymaps actions: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-keymap.md
	-- markdown checks: https://github.com/bngarren/checkmate.nvim
	-- https://www.reddit.com/r/neovim/comments/1kzwp30/how_much_do_you_pay_for_using_your_ai_plugin/
	-- https://github.com/pwntester/octo.nvim (check prs from neovim)
	-- https://github.com/yarospace/dev-tools.nvim
	-- https://github.com/hachy/cmdpalette.nvim (wait until only insert mode is available)
}
