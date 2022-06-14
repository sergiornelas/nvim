local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("lspconfig").cssls.setup({})
-- require("lspconfig").jsonls.setup({})
-- require("lspconfig").vimls.setup({
-- 	on_attach = require("aerial").on_attach,
-- })

require("lsp.configs")
require("lsp.handlers").setup()
require("lsp.null-ls")
