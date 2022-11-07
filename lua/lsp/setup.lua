local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local nvim_navic_ok, nvim_navic = pcall(require, "nvim-navic")
local lsp_inlayhints_ok, lsp_inlayhints = pcall(require, "lsp-inlayhints")
local typescript_ok, typescript = pcall(require, "typescript")

if not lspconfig_ok or not cmp_nvim_lsp_ok or not nvim_navic_ok or not lsp_inlayhints_ok or not typescript_ok then
	return
end

local capabilities = cmp_nvim_lsp.default_capabilities()
local keymap = vim.keymap.set
keymap("n", "gq", vim.diagnostic.setloclist, { noremap = true, silent = true })

local keymaps = function(bufnr, client)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	-- if client.name ~= "cssls" and client.name ~= "html" and client.name ~= "jsonls" then
	if client.name == "tsserver" or client.name ~= "sumneko_lua" then
		keymap("n", "gD", vim.lsp.buf.declaration, bufopts)
		keymap("n", "gd", vim.lsp.buf.definition, bufopts)
		keymap("n", "gI", vim.lsp.buf.implementation, bufopts)
		keymap("n", "gS", vim.lsp.buf.signature_help, bufopts)
		keymap("n", "gt", vim.lsp.buf.type_definition, bufopts)
	end
	keymap("n", "gA", vim.lsp.buf.add_workspace_folder, bufopts)
	keymap("n", "gR", vim.lsp.buf.remove_workspace_folder, bufopts)
	keymap("n", "gW", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	keymap("n", "g<leader>", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
	keymap("n", "gL", "<cmd>LspInfo<cr>", bufopts)
end

-- ===========================================================================
typescript.setup({
	server = {
		on_attach = function(client, bufnr)
			keymaps(bufnr, client)
			nvim_navic.attach(client, bufnr)
			lsp_inlayhints.on_attach(client, bufnr) -- Typescript 4.4+
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
		end,
		capabilities = capabilities,
		settings = require("lsp.settings.tsserver").settings,
		-- root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "gulpfile.js", "node_modules"),
	},
})

lspconfig.eslint.setup({
	on_attach = function(_, bufnr)
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	end,
	capabilities = capabilities,
	settings = require("lsp.settings.eslint").settings,
})

lspconfig.jsonls.setup({
	on_attach = function(client, bufnr)
		keymaps(bufnr, client)
		nvim_navic.attach(client, bufnr)
	end,
	capabilities = capabilities,
	init_options = { provideFormatter = false },
})

lspconfig.cssls.setup({
	on_attach = function(client, bufnr)
		keymaps(bufnr, client)
		nvim_navic.attach(client, bufnr)
	end,
	capabilities = capabilities,
})

lspconfig.html.setup({
	on_attach = function(client, bufnr)
		keymaps(bufnr, client)
		nvim_navic.attach(client, bufnr)
	end,
	capabilities = capabilities,
	init_options = { provideFormatter = false },
})

lspconfig.sumneko_lua.setup({
	on_attach = function(client, bufnr)
		keymaps(bufnr, client)
		nvim_navic.attach(client, bufnr)
		lsp_inlayhints.on_attach(client, bufnr)
	end,
	capabilities = capabilities,
	settings = require("lsp.settings.sumneko_lua").settings,
})

-- keymaps
-- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
-- navic
-- inlayhints
-- client.server_capabilities.documentFormattingProvider
-- client.server_capabilities.documentRangeFormattingProvider

-- capabilities
-- settings
-- init_options

-- for _, server in ipairs({ "html", "jsonls" }) do
-- 	lspconfig[server].setup({
-- 		on_attach = function(client, bufnr)
-- 			keymaps(bufnr, client)
-- 			nvim_navic.attach(client, bufnr)
-- 		end,
-- 		capabilities = capabilities,
-- 	})
-- end
