local M = {
	"cbochs/grapple.nvim",
	dependencies = "nvim-lua/plenary.nvim",
}

function M.config()
	local grapple_ok, grapple = pcall(require, "grapple")
	if not grapple_ok then
		return
	end

	grapple.setup({
		scope = "git",
		popup_options = {
			width = 60,
			height = 10,
		},
	})
end

return M
