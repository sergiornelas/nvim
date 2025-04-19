return {
	"aznhe21/actions-preview.nvim",
	cond = not vim.g.vscode,
	keys = {
		{
			"gra", -- (vim: vim.lsp.buf.code_action() (v0.11))
			"<cmd>lua require('actions-preview').code_actions()<cr>",
			mode = { "n", "v" },
		},
	},
	config = function()
		require("actions-preview").setup({
			highlight_command = {
				require("actions-preview.highlight").delta(
					"delta --no-gitconfig --hunk-header-style raw --hunk-header-decoration-style none --file-style omit"
				),
			},
			backend = { "snacks" },
			-- not working properly in typescript-tools, only ivy is working
			snacks = {
				layout = {
					layout = {
						box = "vertical",
						backdrop = false,
						row = -1,
						width = 0,
						height = 0.4,
						border = "top",
						title = " {title} {live} {flags}",
						title_pos = "left",
						{ win = "input", height = 1, border = "bottom" },
						{
							box = "horizontal",
							{ win = "list", border = "none" },
							{ win = "preview", title = "{preview}", width = 0.65, border = "left" },
						},
					},
				},
			},
		})
	end,
	-- alternative: tiny-code-action
	-- but doesn't allow me to personalize delta args
}
