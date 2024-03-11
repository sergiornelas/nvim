return {
	{
		"Exafunction/codeium.vim",
		event = "BufEnter",
		config = function()
			vim.keymap.set("i", "<c-i>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true, silent = true })

			-- (vim: not used (but by default it's in 'cinkeys' to re-indent the current line))
			vim.keymap.set("i", "<c-f>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true, silent = true })

			vim.keymap.set("i", "<c-b>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true, silent = true })

			vim.keymap.set("i", "<c-l>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true, silent = true })

			vim.keymap.set("n", "<space>C", function()
				return vim.fn["codeium#Chat"]()
			end, { expr = true, silent = true })
		end,
	},
	{
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		lazy = false,
		config = function()
			require("codeium").setup({})
		end,
	},
}
