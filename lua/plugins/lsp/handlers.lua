local keymap = vim.keymap.set

keymap("n", "go", '<cmd>lua vim.diagnostic.open_float(0, { scope = "cursor", border = "single" })<CR>') -- (vim: cursor to byte N in the buffer)
keymap("n", "gl", '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", border = "single" })<CR>')
keymap("n", "gB", '<cmd>lua vim.diagnostic.open_float(0, { scope = "buffer", border = "double" })<CR>')
keymap("n", "[d", vim.diagnostic.goto_prev) -- (vim: show first #define found in current and included files matching the word under the cursor, start searching at beginning of current file)
keymap("n", "]d", vim.diagnostic.goto_next) -- (vim: show first #define found in current and included files matching the word under thekeymap( cursor, start searching at cursor position)
keymap(
	"n",
	"[e",
	"<cmd>lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR, float = { border = { '╭', '~', '╮', '│', '╯', '─', '╰', '│' } } })<CR>"
)
keymap(
	"n",
	"]e",
	"<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR, float = { border = { '╭', '~', '╮', '│', '╯', '─', '╰', '│' } } })<CR>"
)
keymap("n", "<leader>q", vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		local lsp = vim.lsp.buf
		local opts = { buffer = ev.buf }
		keymap("n", "gy", lsp.declaration, opts)
		keymap("n", "gd", lsp.definition, opts) -- (vim: go to definition of word under the cursor in current function)
		keymap("n", "K", lsp.hover, opts) -- (vim: lookup Keyword under the cursor with 'keywordprg')
		keymap("n", "gz", lsp.implementation, opts)
		keymap("n", "gs", lsp.signature_help, opts) -- (vim: go to sleep for N seconds (default 1))
		keymap("n", "<leader>la", lsp.add_workspace_folder, opts)
		keymap("n", "<leader>lx", lsp.remove_workspace_folder, opts)
		keymap("n", "<leader>ll", function()
			print(vim.inspect(lsp.list_workspace_folders()))
		end, opts)
		keymap("n", "<leader>D", lsp.type_definition, opts)
		keymap("n", "<leader>rn", lsp.rename, opts)
		-- keymap({ "n", "v" }, "", lsp.code_action, opts)
		keymap("n", "ga", lsp.references, opts) -- (vim: print ascii value of character under the cursor)
		keymap("n", "gx", function()
			lsp.format({ async = true }) -- (vim: execute application for file name under the cursor (only with |netrw| plugin))
		end, opts)
	end,
	keymap("n", "gL", "<cmd>LspInfo<cr>"),
})

local M = {}

M.on_attach = function(client, bufnr)
	require("nvim-navic").attach(client, bufnr)
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint(0, true)
		-- vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#747D83", bg = "#333232", italic = true })
	end
	if client.name == "typescript-tools" then
		keymap("n", "gS", "<cmd>TSToolsGoToSourceDefinition<cr>")
	end
end

return M
