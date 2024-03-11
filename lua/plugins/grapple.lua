local M = {
	"cbochs/grapple.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	keys = {
		{ "<leader>m", "<cmd>Grapple toggle<cr>" },
		{ "<leader>p", "<cmd>Grapple open_tags<cr>" },
		{ "<leader>P", "<cmd>Grapple open_tags scope=global<cr>" },
		{ "<leader>gn", ":Grapple tag name=~" },
		{ "<leader>gN", ":Grapple tag scope=global name=~" },
		{ "<leader>gq", "<cmd>Grapple quickfix<cr>" },
		{ "<leader>1", "<cmd>Grapple select index=1<cr>" },
		{ "<leader>2", "<cmd>Grapple select index=2<cr>" },
		{ "<leader>3", "<cmd>Grapple select index=3<cr>" },
		{ "<leader>4", "<cmd>Grapple select index=4<cr>" },
		{ "<leader>5", "<cmd>Grapple select index=5<cr>" },
		{ "<leader>6", "<cmd>Grapple select index=6<cr>" },
		{ "<leader>7", "<cmd>Grapple select index=7<cr>" },
		{ "<leader>8", "<cmd>Grapple select index=8<cr>" },
		{ "<leader>9", "<cmd>Grapple select index=9<cr>" },
		{ "<leader>0", "<cmd>Grapple select index=10<cr>" },
		{ "<c-c>", "<cmd>Grapple cycle_backward<cr>" },
		{ "<c-g>", "<cmd>Grapple cycle_forward<cr>" },
	},
}

function M.config()
	local grapple_ok, grapple = pcall(require, "grapple")
	if not grapple_ok then
		return
	end

	grapple.setup({
		win_opts = {
			width = 60,
			height = 10,
		},
	})
end

return M
