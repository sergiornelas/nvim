return {
	"jackMort/ChatGPT.nvim",
	cmd = {
		"ChatGPT",
		"ChatGPTActAs",
		"ChatGPTCompleteCode",
		"ChatGPTEditWithInstructions",
		"ChatGPTRun",
	},
	config = function()
		require("chatgpt").setup({
			api_key_cmd = "echo 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",
		})
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
}
