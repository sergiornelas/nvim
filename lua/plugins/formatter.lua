return {
	"mhartington/formatter.nvim",
	event = "BufReadPre",
	config = function()
		local util = require("formatter.util")

		require("formatter").setup({
			filetype = {
				lua = {
					require("formatter.filetypes.lua").stylua,
					function()
						-- Supports conditional formatting
						-- if util.get_current_buffer_file_name() == "special.lua" then
						-- 	return nil
						-- end
						return {
							exe = "stylua",
							args = {
								"--search-parent-directories",
								"--stdin-filepath",
								util.escape_path(util.get_current_buffer_file_path()),
								"--",
								"-",
							},
							stdin = true,
						}
					end,
				},
				javascript = {
					require("formatter.filetypes.javascript").prettierd,
				},
				javascriptreact = {
					require("formatter.filetypes.javascriptreact").prettierd,
				},
				typescript = {
					require("formatter.filetypes.typescript").prettierd,
				},
				typescriptreact = {
					require("formatter.filetypes.typescriptreact").prettierd,
				},
				json = {
					require("formatter.filetypes.json").prettierd,
				},
				css = {
					require("formatter.filetypes.css").prettierd,
				},
				html = {
					require("formatter.filetypes.html").prettierd,
				},
			},
		})
		-- Format after save
		vim.api.nvim_exec(
			[[
        augroup FormatAutogroup
        autocmd!
        autocmd BufWritePost * FormatWrite
        augroup END
      ]],
			false
		)
	end,
}
