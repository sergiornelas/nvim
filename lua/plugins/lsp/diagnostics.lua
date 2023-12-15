local M = {}

function M.setup()
	local signs = {
		{ name = "DiagnosticSignError", text = "🔥" },
		{ name = "DiagnosticSignHint", text = "🔎" },
		{ name = "DiagnosticSignInfo", text = "ℹ️" },
		{ name = "DiagnosticSignWarn", text = "⚠️" },
	}
	local hoverBorder = {
		{ "╭", "FloatBorder" },
		{ "─", "FloatBorder" },
		{ "╮", "FloatBorder" },
		{ "│", "FloatBorder" },
		{ "╯", "FloatBorder" },
		{ "─", "FloatBorder" },
		{ "╰", "FloatBorder" },
		{ "│", "FloatBorder" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end
	vim.diagnostic.config({
		virtual_text = true, -- disable virtual text
		signs = {
			active = signs, -- show signs
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "single",
			header = "",
			-- source = "always",
			-- prefix = "",
		},
	})

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = hoverBorder,
		title = "   ",
	})
end

return M
