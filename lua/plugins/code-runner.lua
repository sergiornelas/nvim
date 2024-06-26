-- npm install -g typescript
return {
	{
		"CRAG666/code_runner.nvim",
		cmd = { "RunCode", "RunFile" },
		keys = {
			{ "<leader><cr>", "<cmd>RunCode<cr>" },
			{ "<leader>J", "<cmd>tabnew ~/scratchFiles/scratch.ts<cr><cmd>RunCode<cr>" },
		},
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
			-- SyntaxError: Cannot use import statement outside a module
			-- project = {
			-- 	["~/Desktop/coding/react/"] = {
			-- 		name = "react",
			-- 		description = "React pet project",
			-- 		file_name = "src/App.js",
			-- 	},
			-- },
		},
	},
}
