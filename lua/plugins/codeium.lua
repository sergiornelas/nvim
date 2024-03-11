return {
	{
		"Exafunction/codeium.vim",
		event = "BufEnter",
		config = function()
			vim.cmd([[
        let g:codeium_disable_bindings = 1
        let g:codeium_no_map_tab = 1
        inoremap <silent><expr> <c-g>
        \ exists('b:_codeium_completions') && !empty(get(b:_codeium_completions, 'items', [])) ?
        \ codeium#Accept() : "\<c-g>"
      ]])

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
