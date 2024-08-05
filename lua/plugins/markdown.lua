return {
	{
		"MeanderingProgrammer/markdown.nvim",
		main = "render-markdown",
		ft = "markdown",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("render-markdown").setup({
				heading = {
					width = "block",
				},
				code = {
					style = "normal",
					width = "block",
				},
				dash = {
					width = 80,
				},
				checkbox = {
					unchecked = {
						icon = " ",
					},
					checked = {
						icon = " ",
					},
					custom = {
						todo = { raw = "[-]", rendered = " ", highlight = "RenderMarkdownTodo" },
						uncertain = { raw = "[?]", rendered = " ", highlight = "RenderMarkdownH6" },
						urgent = { raw = "[!]", rendered = " ", highlight = "RenderMarkdownH2" },
					},
				},
			})
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		config = function()
			vim.g.mkdp_auto_close = 0
			vim.g.mkdp_page_title = "<${name}/>"
			vim.cmd([[
        let g:mkdp_preview_options = {
        \ 'disable_sync_scroll': 1,
        \ }
      ]])
			vim.keymap.set("n", "<leader>m", "<cmd>MarkdownPreview<cr>", { noremap = true, silent = true })
		end,
	},
	{
		"sergiornelas/cloak.nvim",
		ft = "markdown",
		config = function()
			require("cloak").setup({
				cloak_length = 9,
				-- Whether it should try every pattern to find the best fit or stop after the first.
				try_all_patterns = true,
				patterns = {
					{
						-- Match any file starting with '.env'.
						-- This can be a table to match multiple file patterns.
						file_pattern = "*.md",
						-- Match an equals sign and any character after it.
						-- This can also be a table of patterns to cloak,
						-- example: cloak_pattern = { ':.+', '-.+' } for yaml files.
						cloak_pattern = "::.+",
						-- A function, table or string to generate the replacement.
						replace = nil,
					},
				},
			})
		end,
	},
	{
		"opdavies/toggle-checkbox.nvim",
		keys = {
			{
				"<c-]>", -- (vim :ta to ident under cursor)
				"<cmd>lua require('toggle-checkbox').toggle()<CR>",
			},
		},
	},
}
