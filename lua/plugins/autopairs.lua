return {
	"windwp/nvim-autopairs",
	dependencies = "nvim-cmp",
	event = "InsertEnter",
	config = function()
		local nvim_autopairs_ok, nvim_autopairs = pcall(require, "nvim-autopairs")
		if not nvim_autopairs_ok then
			return
		end
		nvim_autopairs.setup({
			check_ts = true, -- treesitter integration
			disable_filetype = { "TelescopePrompt" },
			map_c_h = true,
		})
	end,
}
