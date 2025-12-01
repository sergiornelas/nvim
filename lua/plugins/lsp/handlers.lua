-- Interesting LSP config:
-- https://github.com/MariaSolOs/dotfiles/blob/597848ee02e6500454d6b5817a1ed0928e80dafa/.config/nvim/lua/lsp.lua#L105-L119
local keymap = vim.keymap.set
local methods = vim.lsp.protocol.Methods

keymap("n", "gB", '<cmd>lua vim.diagnostic.open_float(0, { scope = "buffer", border = "double" })<CR>')
keymap("n", "<leader>ls", vim.diagnostic.setloclist)
keymap("n", "<leader>lS", vim.diagnostic.setqflist)

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		local lsp = vim.lsp.buf
		local opts = { buffer = ev.buf }
		-- keymap("n", "", lsp.declaration, opts) -- not supported by any of the servers registered: (lua, ts)
		keymap("n", "gd", lsp.definition, opts) -- (vim: go to definition of word under the cursor in current function)
		keymap("n", "gs", lsp.signature_help, opts) -- (vim: go to sleep for N seconds (default 1))
		keymap("i", "<c-g><c-s>", lsp.signature_help, opts)
		keymap("n", "<leader>lA", lsp.add_workspace_folder, opts)
		keymap("n", "<leader>lR", lsp.remove_workspace_folder, opts)
		keymap("n", "<leader>lL", function()
			print(vim.inspect(lsp.list_workspace_folders()))
		end, opts)
		keymap("n", "<leader>D", lsp.type_definition, opts)
		keymap("n", "<leader>lf", function()
			lsp.format({ async = true })
		end, opts)
		keymap("n", "<leader>lI", lsp.incoming_calls, opts)
		keymap("n", "<leader>lO", lsp.outgoing_calls, opts)
		keymap("n", "<leader>lw", lsp.workspace_symbol, opts)
		keymap({ "n", "x" }, "<leader>i", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
		end)
		keymap("i", "<c-g><c-i>", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
		end)
		keymap({ "n", "x" }, "<leader>lt", function()
			if vim.diagnostic.is_enabled() then
				vim.diagnostic.enable(false)
			else
				vim.diagnostic.enable()
			end
		end)
	end,
	keymap("n", "gL", "<cmd>LspInfo<cr>"),
})

local M = {}

M.on_attach = function(client, bufnr)
	require("nvim-navic").attach(client, bufnr)
	if client.supports_method(methods.textDocument_inlayHint) then
		vim.lsp.inlay_hint.enable(false)
		-- vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#747D83", bg = "#333232", italic = true })
	end
	-- if client.name == "typescript-tools" then
	-- 	keymap("n", "go", "<cmd>TSToolsGoToSourceDefinition<cr>") -- (vim: cursor to byte N in the buffer)
	-- end
end

return M
