return {
	"echasnovski/mini.indentscope",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		draw = {
			animation = function()
				return 0
			end,
		},
		mappings = {
			object_scope = "<c-o>", -- (vim: switch from Select to Visual mode for one command)
			object_scope_with_border = "<c-i>",
			goto_top = "[t",
			goto_bottom = "]t",
		},
	},
	config = function(_, opts)
		require("mini.indentscope").setup(opts)

		-- Disable for certain filetypes
		vim.api.nvim_create_autocmd({ "FileType" }, {
			callback = function()
				local ignore_filetypes = {
					"lazy",
					"mason",
				}
				if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
					vim.b.miniindentscope_disable = true
				end
			end,
		})
	end,
}
