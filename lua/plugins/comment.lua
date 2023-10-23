local M = {
	{
		"numToStr/Comment.nvim",
		keys = {
			{ "gc", mode = { "n", "x" } },
			{ "gb", mode = { "n", "x" } },
		},
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			local comment_ok, comment = pcall(require, "Comment")
			if not comment_ok then
				return
			end

			comment.setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
				toggler = {
					line = "gcc",
					block = "gbc",
				},
				opleader = {
					line = "gc",
					block = "gb",
				},
				extra = {
					-- Add comment on the line above
					above = "gcK",
					-- Add comment on the line below
					below = "gcJ",
					-- Add comment at the end of line
					eol = "gcA",
				},
			})
		end,
	},
}

return M
