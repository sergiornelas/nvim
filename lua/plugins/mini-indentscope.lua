return {
	"echasnovski/mini.indentscope",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		draw = {
			delay = 100,
			-- animation = indentscope.gen_animation.none(),
		},
		mappings = {
			object_scope = "ij",
			object_scope_with_border = "aj",
			goto_top = "[f", -- (vim: same as "gf")
			goto_bottom = "]f", -- (vim: same as "gf")
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
