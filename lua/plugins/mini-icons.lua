return {
	"nvim-mini/mini.icons",
	version = "*",
	opts = {},
	-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/ui.lua#L259
	-- replace nvim-web-devicons with mini.icons (useful for grapple.nvim)
	init = function()
		package.preload["nvim-web-devicons"] = function()
			require("mini.icons").mock_nvim_web_devicons()
			return package.loaded["nvim-web-devicons"]
		end
	end,
}
