local M = {
	"cbochs/grapple.nvim",
	event = "BufReadPost",
	keys = {
		{ "g<leader>", "<cmd>Grapple toggle<cr>" },
		{ "<leader>go", "<cmd>Grapple open_tags<cr>" },
		{ "<leader>gk", "<cmd>Grapple open_tags scope=bookmarks<cr>" },
		{ "<leader>ga", "<cmd>Grapple open_tags scope=global<cr>" },
		{ "<leader>gb", ":Grapple tag scope=bookmarks name=" },
		{ "<leader>gy", ":Grapple tag scope=global name=~" },
		{ "<leader>gq", "<cmd>Grapple quickfix<cr>" },
		{ "<c-1>", "<cmd>Grapple select index=1<cr>" },
		{ "<c-2>", "<cmd>Grapple select index=2<cr>" },
		{ "<c-3>", "<cmd>Grapple select index=3<cr>" },
		{ "<c-4>", "<cmd>Grapple select index=4<cr>" },
		{ "<c-5>", "<cmd>Grapple select index=5<cr>" },
		{ "<c-g>", "<cmd>Grapple cycle_tags next<cr>" }, -- (vim: display current file name and position)
		{ "<c-t>", "<cmd>Grapple cycle_tags prev<cr>" }, -- (vim: jump to N older Tag in tag list)
	},
}

function M.config()
	local grapple_ok, grapple = pcall(require, "grapple")
	if not grapple_ok then
		return
	end

	grapple.setup({
		name_pos = "start",
		style = "basename",
		win_opts = {
			width = 70,
		},
		scopes = {
			{
				name = "bookmarks",
				fallback = "cwd",
				cache = { event = "DirChanged" },
				resolver = function()
					---@diagnostic disable-next-line: undefined-field
					local root = vim.loop.cwd()
					local id = string.format("%s:%s", root, "bookmarks")
					local path = root
					return id, path
				end,
			},
		},
	})
end

return M
