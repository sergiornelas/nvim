local present1, lspconfig = pcall(require, "lspconfig")
local present2, null_ls = pcall(require, "null-ls")
local present3, _ = pcall(require, "nvim-lsp-ts-utils")

if not (present1 or present2 or present3) then
	return
end

--=================={TSSERVER}=========================
--  > npm install -g typescript typescript-language-server
--  > npm install -g eslint_d
--  > npm install -g prettierd

-- This plugin adds useful commands to organize and update imports, provides integration
--  with null_ls to lint files with ESLint and format files with Prettier.

-- Wrapper to more easily define keybindings:
local buf_map = function(bufnr, mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
		silent = true,
	})
end

local on_attach = function(client, bufnr)
	vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
	vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
	vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
	vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
	vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
	vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
	vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
	vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
	vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
	vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
	vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float()")
	vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
	buf_map(bufnr, "n", "gd", ":LspDef<CR>")
	buf_map(bufnr, "n", "gr", ":LspRename<CR>")
	buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>")
	buf_map(bufnr, "n", "K", ":LspHover<CR>")
	buf_map(bufnr, "n", "[d", ":LspDiagPrev<CR>")
	buf_map(bufnr, "n", "]d", ":LspDiagNext<CR>")
	buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>")
	buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>")
	if client.resolved_capabilities.document_formatting then
		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		-- vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()")
	end
end

-- Highlight
local function lsp_highlight_document(client)
	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
			false
		)
	end
end

-- Set up the tsserver itself, modify capabilites to avoid conflicts with null_ls
--  and set up the utilities and integrations from nvim-lsp-ts-utils.
--  Prettier is behind the scenes active, so en client.resolved we deactivate
--  because we use prettierd in null-ls.
lspconfig.tsserver.setup({ --*
	on_attach = function(client, bufnr)
		-- tsserver weak formatting
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
		lsp_highlight_document(client)

		-- nvim-lsp-ts-utils:
		local ts_utils = require("nvim-lsp-ts-utils")
		ts_utils.setup({})
		-- required to fix code action ranges and filter diagnostics
		ts_utils.setup_client(client)
		buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
		buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
		buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
		-- runs whenever we open a file that tsserver supports
		on_attach(client, bufnr)
	end,
})

--=================={null_ls}===========================
-- NULL (LSP ACTIONS USING PURE LUA, NO CONNECTION WITH A LSP SERVER, ALLOWS TYPES OF FORMAT AND DIFFERENT ACTIONS)
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

-- YOU COULD DISABLE TSSERVER DIAGNOSTICS
null_ls.setup({
	debug = false,
	sources = {
		diagnostics.eslint_d.with({ --js, ts, jsx, tsx (also has formatting)
			filetypes = { "javascript", "javascriptreact" }, --(ts, tsx ommited)
		}),
		code_actions.eslint_d.with({ --js, ts, jsx, tsx (also has formatting)
			filetypes = { "javascript", "javascriptreact" }, --(ts, tsx ommited)
		}),
		formatting.prettierd, --html, css, js, ts, jsx, tsx, json
		diagnostics.tidy, --html (also has formatting)
		formatting.stylua, --lua (also has range_formatting)
		code_actions.gitsigns, -- *
		-- diagnostics.jsonlint, --json
		-- LSP status===============
		--  JS, JSX, TS, TSX completions: tsserver*
		--  TS, TSX diagnostics: tsserver*, BUT LOOKS LIKE JS FILES ALSO APPLIES
		--  HTML completions: html (formatting turned off for prettier)
		--  CSS completions: cssls
		--  CSS diagnostics: cssls
		--  Lua diagnostics: sumneko_lua (also has a weak formatting)

		-- diagnostics.eslint_d.with({
		-- 	filetypes = { "javascript" },
		-- }),
		-- code_actions.eslint_d.with({
		-- 	filetypes = { "javascript" },
		-- }),
		-- formatting.deno_fmt.with({
		-- 	extra_args = { "--options-single-quote" },
		-- }),

		-- -- :LspInfo => Other clients that match the filetype:...
		-- -- formatting.prettier.with only works on regular prettier.
		-- formatting.prettier.with({
		-- 	disabled_filetypes = {
		-- 		"javascript",
		-- 		"javascriptreact",
		-- 		"typescript",
		-- 		"typescriptreact",
		-- 	},
		-- 	extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
		-- }),

		-- diagnostics.eslint.with({
		--     prefer_local = "node_modules/.bin",      -- Use eslint to a project-local executable form node_modules
		--                                              --  when available but fall back to a global executable.
		-- --  only_local = "node_modules/.bin",        -- Use eslint to ONLY run when a project-local executable is
		--                                              --  available in node_modules.
		-- }),
	},
	on_attach = on_attach,
})
