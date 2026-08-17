-- Disable prompts in vtsls and tsc
-- local original_progress_handler = vim.lsp.handlers["$/progress"]
-- vim.lsp.handlers["$/progress"] = function(err, result, ctx, config)
-- 	local client = vim.lsp.get_client_by_id(ctx.client_id)
-- 	-- Filter vtsls
-- 	if client and (client.name == "vtsls" or client.name == "tsc") then
-- 		return
-- 	end
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
