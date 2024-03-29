return {
	"echasnovski/mini.trailspace",
	ft = { "norg", "md" },
	keys = {
		{ "<leader>b", "<cmd>lua require('mini.trailspace').trim()<cr>" },
	},
	config = function()
		local trailspace_ok, trailspace = pcall(require, "mini.trailspace")
		if not trailspace_ok then
			return
		end
		trailspace.setup()
	end,
}
