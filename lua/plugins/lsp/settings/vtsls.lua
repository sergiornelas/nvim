-- Disable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx)
	if vim.lsp.get_client_by_id(ctx.client_id) and vim.lsp.get_client_by_id(ctx.client_id).name == "vtsls" then
		return
	end
	vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
end

-- Disable prompts in vtsls and tsgo
-- local original_progress_handler = vim.lsp.handlers["$/progress"]
-- vim.lsp.handlers["$/progress"] = function(err, result, ctx, config)
-- 	local client = vim.lsp.get_client_by_id(ctx.client_id)
-- 	-- Filtrar vtsls
-- 	if client and (client.name == "vtsls" or client.name == "tsgo") then
-- 		return
-- 	end
-- 	-- Llamar al handler original (no al sobrescrito)
-- 	return original_progress_handler(err, result, ctx, config)
-- end

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
