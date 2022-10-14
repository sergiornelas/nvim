local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
	return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

null_ls.setup({
	debug = false,
	sources = {
		diagnostics.eslint_d,
		diagnostics.tidy,
		formatting.prettierd,
		formatting.stylua,
		-- formatting.prettier.with {
		--       extra_filetypes = { "toml", "solidity" },
		--       extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
		--     },
	},
	-- format on save:
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format()
				end,
			})
		end
	end,
})
