return {
	{
		"jakewvincent/mkdnflow.nvim",
		ft = { "markdown" },
		config = function()
			require("mkdnflow").setup({
				create_dirs = true,
				mappings = {
					MkdnNextHeading = { "n", "]e" },
					MkdnPrevHeading = { "n", "[e" },
					MkdnCreateLinkFromClipboard = { { "n", "v" }, "<leader>mc" },
					MkdnDestroyLink = { "n", "<leader>md" },
					MkdnTagSpan = { "v", "<leader>mt" },
					MkdnYankFileAnchorLink = { "n", "yaA" },
					MkdnToggleToDo = { { "n", "v" }, "<c-]>" }, -- (vim: :ta to ident under cursor, jump to highlighted tag)
					MkdnUpdateNumbering = { "n", "<leader>mn" },
					-- MkdnTablePrevRow = { "i", "<leader>ma" },
					MkdnTableNewRowBelow = { "n", "<leader>mir" },
					MkdnTableNewRowAbove = { "n", "<leader>miR" },
					MkdnTableNewColAfter = { "n", "<leader>mic" },
					MkdnTableNewColBefore = { "n", "<leader>miC" },
					MkdnFoldSection = { "n", "<leader>mf" },
					MkdnUnfoldSection = { "n", "<leader>mF" },
				},
			})
		end,
	},
	{
		"MeanderingProgrammer/markdown.nvim",
		ft = "markdown",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("render-markdown").setup({
				-- headings = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
				headings = { "☥ ", "☯ ", "▲ ", "⌘ ", "⛧ ", "☪ " },
				highlights = {
					heading = {
						backgrounds = { "MarkdownHeader1", "MarkdownHeader2", "" },
					},
					code = "",
				},
			})
		end,
	},
	{
		"laytan/cloak.nvim",
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
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		config = function()
			vim.g.mkdp_auto_close = 0
			vim.g.mkdp_page_title = "<${name}/>"
			vim.keymap.set("n", "<leader>me", "<cmd>MarkdownPreview<cr>", { noremap = true, silent = true })
		end,
	},
	{
		"crispgm/telescope-heading.nvim",
		keys = {
			{ "<leader>fh", "<cmd>Telescope heading<cr>" },
		},
	},
}
