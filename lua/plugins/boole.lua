return {
	"nat-418/boole.nvim",
	keys = {
		"<c-z>",
		"<c-x>",
	},
	config = function()
		local boole_ok, boole = pcall(require, "boole")
		if not boole_ok then
			return
		end
		boole.setup({
			mappings = {
				increment = "<C-x>",
				decrement = "<C-z>",
			},
		})
	end,
}
