-- npm install -g typescript
return {
	{
		"CRAG666/code_runner.nvim",
		cmd = { "RunCode", "RunFile" },
		keys = {
			{ "<leader><cr>", "<cmd>RunCode<cr>" },
			{ "<leader>J", "<cmd>tabnew ~/scratchFiles/scratch.js<cr><cmd>RunCode<cr>" },
		},
		opts = {
			focus = false,
			startinsert = false,
			term = {
				size = 19,
			},
			filetype = {
				javascript = "nvm use lts && node --watch",
				typescript = "nvm use lts && node --watch",
				javascriptreact = "nvm use lts && node --watch",
				typescriptreact = "nvm use lts && node --watch",
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
