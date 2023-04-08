local M = {
	"petertriho/nvim-scrollbar",
	event = "BufReadPost",
}

function M.config()
	local scrollbar_ok, scrollbar = pcall(require, "scrollbar")
	if not scrollbar_ok then
		return
	end

	scrollbar.setup({
		handlers = {
			handle = true,
			gitsigns = true, --requires gitsigns
			-- search = false, --requires hlslens
		},
		excluded_filetypes = { "prompt", "TelescopePrompt", "noice", "notify", "NvimTree", "Navbuddy", "DiffviewFiles" },
	})
end

return M
