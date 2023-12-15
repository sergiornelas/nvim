return {
	"jackMort/ChatGPT.nvim",
	cmd = {
		"ChatGPT",
		"ChatGPTActAs",
		"ChatGPTCompleteCode",
		"ChatGPTEditWithInstructions",
		"ChatGPTRun",
	},
	keys = {
		{ "<c-c>", "<cmd>ChatGPT<cr>" }, -- (vim: interrupt current (search) command)
	},
	config = function()
		require("chatgpt").setup({
			-- api_key_cmd = "pass show chatgpt",
		})
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
}
