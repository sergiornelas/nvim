local M = {}

function M.apply(client)
	local caps = client.server_capabilities

	-- UX / interaction
	caps.hoverProvider = false
	caps.completionProvider = false
	caps.definitionProvider = false
	caps.declarationProvider = false
	caps.implementationProvider = false
	caps.referencesProvider = false
	caps.renameProvider = false
	caps.codeActionProvider = false
	caps.signatureHelpProvider = false
	caps.documentHighlightProvider = false

	-- symbols / navegation
	caps.documentSymbolProvider = false
	caps.workspaceSymbolProvider = false

	-- format / tokens
	caps.documentFormattingProvider = false
	caps.documentRangeFormattingProvider = false
	caps.semanticTokensProvider = nil

	-- other
	caps.typeDefinitionProvider = false
	caps.callHierarchyProvider = false
	caps.selectionRangeProvider = false

	-- diagnostics: no touch
	-- textDocument/publishDiagnostics no depende de capabilities
end

return M
