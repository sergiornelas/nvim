local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
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
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "<leader>lo", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
	keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
	keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
	keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
	keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
	keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
	keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

M.on_attach = function(client, bufnr)
	-- Add LSP keymaps
	lsp_keymaps(bufnr)

	if client.name == "tsserver" then
		-- Prettierd in null_ls
		client.resolved_capabilities.document_formatting = false

		-- Ts-utils
		local ts_utils = require("nvim-lsp-ts-utils")
		ts_utils.setup({})
		ts_utils.setup_client(client)
		keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
		keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
		keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
	end

	-- Stylua in null_ls
	if client.name == "sumneko_lua" then
		client.resolved_capabilities.document_formatting = false
	end

	-- Prettierd in null_ls
	if client.name == "html" then
		client.resolved_capabilities.document_formatting = false
	end
	if client.name == "jsonls" then
		client.resolved_capabilities.document_formatting = false
	end

	-- Highlight text
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end

	if vim.g.colors_name ~= "gruvbox-baby" then
		illuminate.on_attach(client)
	end

	-- require("lsp_signature").on_attach() -- Note: add in lsp client on-attach

	-- Format on save (currently all clients formatting are handled by null_ls)
	-- if client.resolved_capabilities.document_formatting then
	--  vim.api.nvim_create_autocmd(
	--    "BufWritePre",
	--    { pattern = "<buffer>", command = "lua vim.lsp.buf.formatting_sync()" }
	--  )
	-- end
end

return M
