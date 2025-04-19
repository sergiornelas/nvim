return {
	"echasnovski/mini.icons",
	cond = not vim.g.vscode,
	opts = {},
	-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/ui.lua#L259
	init = function()
		package.preload["nvim-web-devicons"] = function()
			require("mini.icons").mock_nvim_web_devicons()
			return package.loaded["nvim-web-devicons"]
		end
	end,
}
