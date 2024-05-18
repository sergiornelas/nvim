-- Interesting LSP config:
-- https://github.com/MariaSolOs/dotfiles/blob/597848ee02e6500454d6b5817a1ed0928e80dafa/.config/nvim/lua/lsp.lua#L105-L119
local keymap = vim.keymap.set
local methods = vim.lsp.protocol.Methods

keymap("n", "gB", '<cmd>lua vim.diagnostic.open_float(0, { scope = "buffer", border = "double" })<CR>')
keymap("n", "[d", vim.diagnostic.goto_prev) -- (vim: go to prev diagnostic no float w. (nvim 0.10))
keymap("n", "]d", vim.diagnostic.goto_next) -- (vim: go to next diagnostic no float w. (nvim 0.10))
keymap(
	"n",
	"[e",
	"<cmd>lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR, float = { border = { '┌', '~', '┐', '│', '┘', '─', '└', '│' } } })<CR>"
)
keymap(
	"n",
	"]e",
	"<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR, float = { border = { '┌', '~', '┐', '│', '┘', '─', '└', '│' } } })<CR>"
)

keymap("n", "<leader>ld", vim.diagnostic.setloclist)
keymap("n", "<leader>qd", vim.diagnostic.setqflist)

function ToggleDiagnostic()
	if vim.diagnostic.is_enabled() then
		vim.diagnostic.enable(false)
	else
		vim.diagnostic.enable()
	end
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		local lsp = vim.lsp.buf
		local opts = { buffer = ev.buf }
		-- keymap("n", "gh", lsp.declaration, opts) -- not supported by any of the servers registered: (lua, ts) (vim: start Select mode)
		keymap("n", "gd", lsp.definition, opts) -- (vim: go to definition of word under the cursor in current function)
		keymap("n", "ga", lsp.implementation, opts) -- (vim: print ascii value of character under the cursor)
		keymap("n", "gs", lsp.signature_help, opts) -- (vim: go to sleep for N seconds (default 1))
		keymap("i", "<c-space><c-s>", lsp.signature_help, opts)
		keymap("n", "<leader>lA", lsp.add_workspace_folder, opts)
		keymap("n", "<leader>lR", lsp.remove_workspace_folder, opts)
		keymap("n", "<leader>lL", function()
			print(vim.inspect(lsp.list_workspace_folders()))
		end, opts)
		keymap("n", "<leader>D", lsp.type_definition, opts)
		keymap("n", "<leader>ln", lsp.rename, opts)
		-- keymap({ "n", "x" }, "<leader>la", lsp.code_action, opts) -- using plugin actions-preview
		keymap("n", "<leader>lr", lsp.references, opts)
		keymap("n", "<leader>lf", function()
			lsp.format({ async = true })
		end, opts)
		keymap("n", "<leader>lI", lsp.incoming_calls, opts)
		keymap("n", "<leader>lO", lsp.outgoing_calls, opts)
		keymap("n", "<leader>ls", lsp.document_symbol, opts)
		keymap("n", "<leader>lw", lsp.workspace_symbol, opts)
		keymap("n", "<leader>h", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
		end)
		keymap("x", "<c-space><c-h>", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
		end)
		keymap("n", "<leader>lt", function()
			ToggleDiagnostic()
		end)
		keymap("x", "<c-space><c-l>", function()
			ToggleDiagnostic()
		end)
	end,
	keymap("n", "gL", "<cmd>LspInfo<cr>"),
})

local M = {}

M.on_attach = function(client, bufnr)
	require("nvim-navic").attach(client, bufnr)
	if client.supports_method(methods.textDocument_inlayHint) then
		vim.lsp.inlay_hint.enable(true)
		vim.api.nvim_create_autocmd("InsertEnter", {
			buffer = bufnr,
			callback = function()
				vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
			end,
		})
		vim.api.nvim_create_autocmd("InsertLeave", {
			buffer = bufnr,
			callback = function()
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end,
		})
		-- vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#747D83", bg = "#333232", italic = true })
	end
	if client.name == "typescript-tools" then
		keymap("n", "go", "<cmd>TSToolsGoToSourceDefinition<cr>") -- (vim: cursor to byte N in the buffer)
	end
end

return M
