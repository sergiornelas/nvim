return {
	"mason-org/mason.nvim",
	ft = {
		"css",
		"html",
		"javascript",
		"javascriptreact",
		"json",
		"lua",
		"markdown",
		"typescript",
		"typescriptreact",
		"yaml",
	},
	config = function()
		local mason_ok, mason = pcall(require, "mason")

		if not mason_ok then
			return
		end

		mason.setup()

		-- Names must be Mason package names
		local ensure_installed = {
			"css-lsp",
			"html-lsp",
			"json-lsp",
			"lua-language-server",
			"markdownlint",
			"prettierd",
			"stylua",
			"tsgo",
			"vtsls",
			"yaml-language-server",
		}

		local installed_package_names = require("mason-registry").get_installed_package_names()
		for _, v in ipairs(ensure_installed) do
			if not vim.tbl_contains(installed_package_names, v) then
				vim.cmd(":MasonInstall " .. v)
			end
		end
	end,
}
