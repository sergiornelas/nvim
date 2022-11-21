local null_ls_ok, null_ls = pcall(require, "null-ls")
local typescript_ext_ok, typescript_ext = pcall(require, "typescript.extensions.null-ls.code-actions")

if not null_ls_ok or not typescript_ext_ok then
	return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

null_ls.setup({
	debug = false,
	sources = {
		diagnostics.tidy,
		formatting.prettierd,
		formatting.stylua,
		typescript_ext,
		-- formatting.prettier.with({
		-- 	extra_filetypes = { "toml", "solidity" },
		-- 	extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
		-- }),
	},
	-- format on save:
	on_attach = function(current_client, bufnr)
		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						bufnr = bufnr,
						filter = function(client)
							-- only use null-ls for formatting instead of lsp server
							return client.name == "null-ls"
						end,
					})
				end,
			})
		end
	end,
})
