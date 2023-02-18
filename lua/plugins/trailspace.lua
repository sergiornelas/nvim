return {
	"echasnovski/mini.trailspace",
	ft = { "norg", "md" },
	config = function()
		local trailspace_ok, trailspace = pcall(require, "mini.trailspace")
		if not trailspace_ok then
			return
		end
		trailspace.setup()
	end,
}
