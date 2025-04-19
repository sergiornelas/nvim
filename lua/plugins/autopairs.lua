return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	cond = not vim.g.vscode,
	config = function()
		local nvim_autopairs_ok, nvim_autopairs = pcall(require, "nvim-autopairs")
		if not nvim_autopairs_ok then
			return
		end
		nvim_autopairs.setup({
			check_ts = true, -- treesitter integration
			disable_filetype = { "snacks_picker_input" },
			map_c_h = true,
			map_c_w = true,
			fast_wrap = {
				map = "<c-->",
			},
		})
	end,
}
