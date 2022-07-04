local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local servers = {
	"sumneko_lua",
	"cssls",
	"html",
	-- "tsserver",
	"bashls",
	"jsonls",
	"yamlls",
}

lsp_installer.setup()

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("lsp.handlers").on_attach,
		capabilities = require("lsp.handlers").capabilities,
	}

	-- if server == "tsserver" then
	-- local tsserver_opts = require("lsp.settings.tsserver")
	-- opts = vim.tbl_deep_extend("force", tsserver, opts)
	-- end

	if server == "sumneko_lua" then
		local sumneko_opts = require("lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server == "pyright" then
		local pyright_opts = require("lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end

	lspconfig[server].setup(opts)
end

-- require("typescript").setup({
-- 	disable_commands = false, -- prevent the plugin from creating Vim commands
-- 	debug = false, -- enable debug logging for commands
-- 	server = { -- pass options to lspconfig's setup method
-- 		on_attach = require("lsp.handlers").on_attach,
-- 	},
-- })

-- local util = lsp.util
-- local root_pattern = util.root_pattern
lspconfig.tsserver.setup({
	-- capabilities = capabilities,
	-- on_attach = on_attach(client, bufnr),
	on_attach = require("lsp.handlers").on_attach,
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"javascriptreact",
		"javascript",
		"typescript",
		"typescriptreact",
	},
	-- root_dir = function(fname)
	-- 	local util = lspconfig.util
	-- 	-- 	-- local root_files = {
	-- 	-- 	-- 	"package.json",
	-- 	-- 	-- 	"tsconfig.json",
	-- 	-- 	-- 	"jsconfig.json",
	-- 	-- 	-- }
	-- 	-- 	-- Also tried this, but didn't work
	-- 	-- 	--  return root_pattern(fname) or vim.loop.os_homedir()
	-- 	-- 	-- return util.root_pattern(unpack(root_files))(fname)
	-- 	-- 	-- 	or util.find_git_ancestor(fname)
	-- 	-- 	-- 	or util.path.dirname(fname)
	-- 	--
	-- 	-- return util.root_pattern("tsconfig.json")(fname)
	-- 	-- 	or util.root_pattern("jsconfig.json", ".git")(fname)
	-- 	-- 	or util.path.dirname(fname)
	-- 	return util.path.dirname(fname)
	-- end,
	-- root_dir = require("lspconfig").util.root_pattern("package.json"),
})
