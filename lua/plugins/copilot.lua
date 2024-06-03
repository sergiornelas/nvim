return {
	{
		"github/copilot.vim",
		event = "BufReadPost",
		config = function()
			-- (vim: not used (but by default it's in 'cinkeys' to re-indent the current line))
			vim.keymap.set("i", "<c-f>", 'copilot#Accept("\\<CR>")', {
				expr = true,
				replace_keycodes = false,
			})
			vim.g.copilot_no_tab_map = true
			vim.keymap.set("i", "<c-space>", "<Plug>(copilot-next)")
			vim.keymap.set("i", "<c-;>", "<Plug>(copilot-previous)")
			vim.keymap.set("i", "<c-l>", "<Plug>(copilot-dismiss)")
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = function()
					vim.api.nvim_set_hl(0, "CopilotSuggestion", {
						fg = "#9A6CAB",
						ctermfg = 8,
						force = true,
					})
				end,
			})
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "github/copilot.vim" },
			{ "nvim-lua/plenary.nvim" },
		},
		opts = {
			debug = true,
			window = {
				layout = "float",
				width = 0.7,
				height = 0.7,
				title = " Copilot Chat   ",
			},
			mappings = {
				complete = {
					detail = "Use @<c-i> or /<c-i> for options.",
					insert = "<c-i>",
				},
				close = {
					normal = "q",
					insert = "<c-c>",
				},
				reset = {
					normal = "",
					insert = "",
				},
			},
		},
		keys = {
			{
				"<leader>cv",
				":CopilotChat ",
				mode = { "x" },
			},
			{
				"<leader>h",
				"<cmd>CopilotChatOpen<cr>",
				mode = { "n", "x" },
			},
			{
				"<leader>cs",
				"<cmd>CopilotChatStop<cr>",
				mode = { "n", "x" },
			},
			{
				"<leader>cr",
				"<cmd>CopilotChatReset<cr>",
				mode = { "n", "x" },
			},
			{
				"<leader>ce",
				"<cmd>CopilotChatExplain<cr>",
				mode = { "n", "x" },
			},
			{
				"<leader>cw",
				"<cmd>CopilotChatReview<cr>",
				mode = { "n", "x" },
			},
			{
				"<leader>cf",
				"<cmd>CopilotChatFix<cr>",
				mode = { "n", "x" },
			},
			{
				"<leader>co",
				"<cmd>CopilotChatOptimize<cr>",
				mode = { "n", "x" },
			},
			{
				"<leader>cD",
				"<cmd>CopilotChatDocs<cr>",
				mode = { "n", "x" },
			},
			{
				"<leader>ct",
				"<cmd>CopilotChatTests<cr>",
				mode = { "n", "x" },
			},
			{
				"<leader>cd",
				"<cmd>CopilotChatFixDiagnostic<cr>",
				mode = { "n", "x" },
			},
			{
				"<leader>cc",
				"<cmd>CopilotChatCommit<cr>",
				mode = { "n", "x" },
			},
			{
				"<leader>cC",
				"<cmd>CopilotChatCommitStaged<cr>",
				mode = { "n", "x" },
			},
			{
				"<leader>cb",
				function()
					local input = vim.fn.input("Copilot chat: ")
					if input ~= "" then
						require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
					end
				end,
				mode = { "n", "x" },
			},
		},
	},
}
