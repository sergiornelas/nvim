local M = {
	"kwkarlwang/bufjump.nvim",
	keys = {
		"K",
		"J",
	},
}

function M.config()
	local bufjump_ok, bufjump = pcall(require, "bufjump")
	if not bufjump_ok then
		return
	end

	bufjump.setup({
		forward = "K",
		backward = "J",
	})
end

return M
