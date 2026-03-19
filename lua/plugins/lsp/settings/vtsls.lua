-- Disable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx)
	if vim.lsp.get_client_by_id(ctx.client_id) and vim.lsp.get_client_by_id(ctx.client_id).name == "vtsls" then
		return
	end
	vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
end

return {
	settings = {
		typescript = {
			inlayHints = {
				parameterNames = { enabled = "all" },
				parameterTypes = { enabled = true },
				variableTypes = { enabled = true },
				propertyDeclarationTypes = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				enumMemberValues = { enabled = true },
			},
		},
		javascript = {
			inlayHints = {
				parameterNames = { enabled = "all" },
				parameterTypes = { enabled = true },
				variableTypes = { enabled = true },
				propertyDeclarationTypes = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				enumMemberValues = { enabled = true },
			},
		},
	},
}
