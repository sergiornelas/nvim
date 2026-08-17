local M = {}

-- tsc (TypeScript 7, formerly known as tsgo) is used here solely for its diagnostics:
-- they are much faster than those provided by vtsls. Everything else (hover, code actions,
-- refactors, navigation, ts-expand-hover) is handled by vtsls, so we disable
-- any other capabilities to prevent them from competing.
local KEEP = {
	diagnosticProvider = true, -- pull diagnostics: the sole purpose of tsc
	textDocumentSync = true, -- didOpen/didChange; without these, Neovim's change tracking breaks.
	positionEncoding = true,
}

function M.apply(client)
	local caps = client.server_capabilities
	for name in pairs(caps) do
		if not KEEP[name] then
			caps[name] = nil
		end
	end
end

return M
