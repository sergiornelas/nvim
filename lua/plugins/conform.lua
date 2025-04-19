return {
	"stevearc/conform.nvim",
	cond = not vim.g.vscode,
	keys = {
		{ "<leader>w", "<cmd>w<cr>" },
	},
	event = "InsertLeave",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				json = { "prettierd" },
				css = { "prettierd" },
				html = { "prettierd" },
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				markdown = { "markdownlint" },
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})
	end,
}
