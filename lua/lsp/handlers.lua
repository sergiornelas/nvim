local M = {}

local status_illuminate_ok, illuminate = pcall(require, "illuminate")
if not status_illuminate_ok then
	return
end

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

local status_navic_ok, navic = pcall(require, "nvim-navic")
if not status_navic_ok then
	return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "🔥" },
		{ name = "DiagnosticSignWarn", text = "👀" },
		{ name = "DiagnosticSignHint", text = "💡" },
		{ name = "DiagnosticSignInfo", text = "ℹ️" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = false, -- disable virtual text
		signs = {
			active = signs, -- show signs
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_buf_set_keymap

local function lsp_keymaps(bufnr)
	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "go", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap(bufnr, "n", "g<cr>", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
	keymap(bufnr, "n", "gI", "<cmd>LspInfo<cr>", opts)
	keymap(bufnr, "n", "gq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	keymap(bufnr, "n", "gw", "<cmd>lua vim.lsp.buf.add_workspace_folder<CR>", opts)
	-- lspsaga handles: hover, references, show and jump diagnostics, code actions, rename and signature help.

	-- Unused features:
	-- local bufopts = { noremap = true, silent = true, buffer = bufnr }
	-- vim.keymap.set('n', 'gz', vim.lsp.buf.remove_workspace_folder, bufopts)
	-- vim.keymap.set("n", "gz", function()
	-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, bufopts)
	-- vim.keymap.set("n", "gz", vim.lsp.buf.type_definition, bufopts)
end

M.on_attach = function(client, bufnr)
	lsp_keymaps(bufnr)

	-- Prettierd in null_ls
	if client.name == "tsserver" then
		client.resolved_capabilities.document_formatting = false
	end
	if client.name == "jsonls" then
		client.resolved_capabilities.document_formatting = false
	end
	if client.name == "html" then
		client.resolved_capabilities.document_formatting = false
	end

	-- Stylua in null_ls
	if client.name == "sumneko_lua" then
		client.resolved_capabilities.document_formatting = false
	end

	-- Navic (currently not working on css and html files)
	if client.name ~= "html" and client.name ~= "cssls" then
		navic.attach(client, bufnr)
	end

	-- Highlight text
	if vim.g.colors_name ~= "gruvbox-baby" then
		illuminate.on_attach(client)
	end

	-- Format on save (currently all clients formatting are handled by null_ls)
	-- if client.resolved_capabilities.document_formatting then
	-- 	vim.api.nvim_create_autocmd(
	-- 		"BufWritePre",
	-- 		{ pattern = "<buffer>", command = "lua vim.lsp.buf.formatting_sync()" }
	-- 	)
	-- end
end

return M
