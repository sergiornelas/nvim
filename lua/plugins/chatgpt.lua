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
			api_key_cmd = "echo ",
		})
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
}
