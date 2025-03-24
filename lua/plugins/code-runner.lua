-- npm install -g typescript
-- npm install -g ts-node-dev

return {
	{
		"CRAG666/code_runner.nvim",
		cmd = { "RunCode", "RunFile" },
		keys = {
			{ "<cr>", "<cmd>RunCode<cr>" },
			{ "<leader>J", "<cmd>tabnew ~/scratchFiles/scratch.ts<cr><cmd>RunCode<cr>" },
		},
		opts = {
			focus = false,
			startinsert = false,
			term = {
				size = 13,
			},
			filetype = {
				javascript = "nvm use lts && node --watch",
				typescript = "ts-node-dev --respawn --clear",
				javascriptreact = "nvm use lts && node --watch",
				typescriptreact = "ts-node-dev --respawn --clear",
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
