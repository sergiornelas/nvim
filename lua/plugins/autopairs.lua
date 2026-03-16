return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
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
			map_cr = false,
			fast_wrap = {
				map = "<c-->",
			},
		})

		_G.MUtils = {}

		MUtils.completion_confirm = function()
			return nvim_autopairs.autopairs_cr()
		end

		vim.api.nvim_set_keymap("i", "<c-j>", "v:lua.MUtils.completion_confirm()", { expr = true, noremap = true })
	end,
}
