return {
	"nvimdev/guard.nvim",
	event = "BufReadPre",
	config = function()
		local ft = require("guard.filetype")

		ft("javascript,typescript,javascriptreact,typescriptreact"):fmt("prettierd")
		ft("lua"):fmt("stylua")

		require("guard").setup({
			-- the only options for the setup function
			fmt_on_save = true,
			-- Use lsp if no formatter was defined for this filetype
			lsp_as_default_formatter = false,
		})
	end,
}
