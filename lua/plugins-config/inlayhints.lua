local lsp_inlayhints_ok, lsp_inlayhints = pcall(require, "lsp-inlayhints")
if not lsp_inlayhints_ok then
	return
end

lsp_inlayhints.setup()
