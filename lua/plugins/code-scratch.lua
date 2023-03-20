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
		cmd = "RunCode",
		config = function()
			require("code_runner").setup({
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
			})
		end,
	},
	{
		"LintaoAmons/scratch.nvim",
		cmd = { "Scratch", "ScratchWithName", "ScratchOpen", "ScratchOpenFzf" },
		config = function()
			require("scratch").setup({
				scratch_file_dir = vim.fn.stdpath("cache") .. "/scratch.nvim",
				filetypes = { "js" },
				filetype_details = {
					js = {
						requireDir = false,
						filename = "main",
						content = { "package main", "", "func main() {", "  ", "}" },
						cursor = {
							location = { 4, 2 },
							insert_mode = true,
						},
					},
				},
			})
		end,
	},
}
