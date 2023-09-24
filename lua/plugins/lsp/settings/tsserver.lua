-- https://github.com/microsoft/TypeScript/blob/v5.0.4/src/server/protocol.ts#L3439
-- https://github.com/typescript-language-server/typescript-language-server#inlay-hints-textdocumentinlayhint

return {
	includeInlayParameterNameHints = "all",
	includeInlayParameterNameHintsWhenArgumentMatchesName = true,
	includeInlayFunctionParameterTypeHints = true,
	includeInlayVariableTypeHints = true,
	includeInlayVariableTypeHintsWhenTypeMatchesName = true,
	includeInlayPropertyDeclarationTypeHints = true,
	includeInlayFunctionLikeReturnTypeHints = true,
	includeInlayEnumMemberValueHints = true,
}
