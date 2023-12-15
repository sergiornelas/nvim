return {
	"RRethy/vim-illuminate",
	event = "BufReadPost",
	keys = {
		{ "]t", "<cmd>lua require('illuminate').goto_next_reference(wrap)<cr>" },
		{ "[t", "<cmd>lua require('illuminate').goto_prev_reference(wrap)<cr>" },
	},
	config = function()
		local illuminate_ok, illuminate = pcall(require, "illuminate")
		if not illuminate_ok then
			return
		end

		illuminate.configure({
			delay = 100,
			under_cursor = true,
			filetypes_denylist = {
				"NvimTree",
				"TelescopePrompt",
			},
		})
	end,
}
