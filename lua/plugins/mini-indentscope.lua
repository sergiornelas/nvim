return {
	"nvim-mini/mini.indentscope",
	version = "*",
	event = { "BufReadPre", "BufNewFile", "BufReadPost" },
	opts = {
		draw = {
			animation = function()
				return 0
			end,
		},
		mappings = {
			object_scope = "<c-o>", -- (vim: switch from Select to Visual mode for one command)
			object_scope_with_border = "<c-i>",
			goto_top = "[-", -- using [t (treesitter objects)
			goto_bottom = "]-", -- using ]t (treesitter objects)
		},
	},
	config = function(_, opts)
		local indentscope = require("mini.indentscope")
		indentscope.setup(opts)

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

		vim.keymap.set("o", "o", function()
			local operator = vim.v.operator
			if operator == "d" then
				local scope = indentscope.get_scope()
				local top = scope.border.top
				local bottom = scope.border.bottom
				local row = unpack(vim.api.nvim_win_get_cursor(0))
				local move = ""
				if row == bottom then
					move = "k"
				elseif row == top then
					move = "j"
				end
				local ns = vim.api.nvim_create_namespace("border")
				vim.api.nvim_buf_set_extmark(0, ns, top - 1, 0, {
					end_line = top,
					hl_group = "Substitute",
					hl_eol = true,
				})
				vim.api.nvim_buf_set_extmark(0, ns, bottom - 1, 0, {
					end_line = bottom,
					hl_group = "Substitute",
					hl_eol = true,
				})
				vim.defer_fn(function()
					vim.api.nvim_buf_set_text(0, top - 1, 0, top - 1, -1, {})
					vim.api.nvim_buf_set_text(0, bottom - 1, 0, bottom - 1, -1, {})
					vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
				end, 150)
				return "<esc>" .. move
			else
				return "o"
			end
		end, { expr = true })
	end,
}
