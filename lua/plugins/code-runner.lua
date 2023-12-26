-- npm install -g typescript
return {
	{
		"CRAG666/code_runner.nvim",
		cmd = { "RunCode", "RunFile" },
		keys = {
			{ "<leader>x", "<cmd>RunCode<cr>" },
			{ "<leader>J", "<cmd>tabnew ~/scratchFiles/scratch.ts<cr><cmd>RunCode<cr>" },
		},
		-- commit = "a010649236fe245eaab2641a13228cd601499715", (last commit warning prompt using codi)
		opts = {
			focus = false,
			startinsert = false,
			term = {
				size = 13,
			},
			filetype = {
				javascript = "nvm use 20 && node --watch",
				typescript = "nvm use 20 && node --watch",
				javascriptreact = "nvm use 20 && node --watch",
				typescriptreact = "nvm use 20 && node --watch",
			},
		},
	},
}
