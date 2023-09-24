return {
	{
		"metakirby5/codi.vim",
		cmd = { "Codi", "CodiExpand" },
		config = function()
			vim.cmd([[
          let g:codi#aliases = {
          \ 'javascriptreact': 'javascript',
          \ 'typescriptreact': 'typescript',
          \ }
          let g:codi#autocmd = 'CursorHold'
			 ]])
		end,
		-- npm i -g typescript
		-- npm i -g tsun
		-- works if you don't have empty lines inside a scope. you can use: //
	},
	{
		"CRAG666/code_runner.nvim",
		cmd = { "RunCode", "RunFile" },
		-- commit = "a010649236fe245eaab2641a13228cd601499715", (last commit warning prompt using codi)
		opts = {
			focus = false,
			startinsert = false,
			term = {
				size = 13,
			},
			filetype = {
				javascript = "nvm use latest && node --watch",
				typescript = "deno run --allow-net --watch",
				javascriptreact = "nvm use latest && node --watch",
				typescriptreact = "deno run --allow-net --watch",
			},
		},
	},
}
