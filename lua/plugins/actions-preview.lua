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
						backdrop = true, -- doesn't work with transparent background
						row = 1,
						width = 0.4,
						min_width = 85,
						height = 0.65,
						border = "none",
						box = "vertical",
						{ win = "preview", title = "{preview}", height = 0.7, border = "single" },
						{
							box = "vertical",
							border = "single",
							title = "{title} {live} {flags}",
							title_pos = "center",
							{ win = "input", height = 1, border = "bottom" },
							{ win = "list", border = "none" },
						},
					},
				},
			},
		})
	end,
	-- alternative: tiny-code-action
	-- but doesn't allow me to personalize delta args
}
