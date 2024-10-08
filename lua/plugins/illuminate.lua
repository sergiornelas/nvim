return {
	"RRethy/vim-illuminate",
	event = "BufReadPost",
	config = function()
		local illuminate_ok, illuminate = pcall(require, "illuminate")
		if not illuminate_ok then
			return
		end

		illuminate.configure({
			delay = 100,
			under_cursor = true,
			filetypes_denylist = {
				"TelescopePrompt",
				"lazy",
				"mason",
			},
		})
	end,
}
