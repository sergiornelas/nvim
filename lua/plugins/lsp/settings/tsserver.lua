-- https://github.com/typescript-language-server/typescript-language-server
-- https://github.com/microsoft/TypeScript/blob/v5.0.4/src/server/protocol.ts#L3439

return {
	includeInlayParameterNameHints = "all",
	includeInlayParameterNameHintsWhenArgumentMatchesName = true,
	includeInlayFunctionParameterTypeHints = true,
	includeInlayVariableTypeHints = true,
	includeInlayVariableTypeHintsWhenTypeMatchesName = true,
	includeInlayPropertyDeclarationTypeHints = true,
	includeInlayFunctionLikeReturnTypeHints = true,
	includeInlayEnumMemberValueHints = true,
	quotePreference = "auto",
	includeCompletionsForModuleExports = true,
}
