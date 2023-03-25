return {
	{
		"metakirby5/codi.vim",
		event = "VeryLazy",
		config = function()
			vim.cmd([[
          let g:codi#aliases = {
          \ 'javascriptreact': 'javascript',
          \ 'typescriptreact': 'javascript',
          \ }
			 ]])
		end,
	},
	{
		"CRAG666/code_runner.nvim",
		cmd = { "RunCode", "RunFile" },
		opts = {
			focus = false,
			startinsert = false,
			term = {
				size = 20,
			},
			filetype = {
				javascript = "nvm use latest && node --watch",
				typescript = "deno run --allow-net",
				javascriptreact = "nvm use latest && node --watch",
				typescriptreact = "nvm use latest && node --watch",
			},
		},
	},
}
