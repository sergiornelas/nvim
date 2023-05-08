local M = {
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = function()
			local comment_ok, comment = pcall(require, "Comment")
			if not comment_ok then
				return
			end

			comment.setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
				toggler = {
					line = "gn",
				},
				opleader = {
					line = "ga",
				},
				extra = {
					-- Add comment on the line above
					above = "gaM",
					-- Add comment on the line below
					below = "gam",
					---Add comment at the end of line
					eol = "gaA",
				},
			})
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	},
}

return M
