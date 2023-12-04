return {
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
