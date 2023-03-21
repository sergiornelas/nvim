local M = {
	"kylechui/nvim-surround",
	version = "*",
	event = "BufReadPost",
}

function M.config()
	local nvim_surround_ok, nvim_surround = pcall(require, "nvim-surround")
	if not nvim_surround_ok then
		return
	end

	nvim_surround.setup({
		keymaps = {
			insert = "<c-x>s",
			insert_line = "<c-x>S",
			normal = "dm",
			normal_cur = "dmm",
			normal_line = "dM",
			normal_cur_line = "dMM",
			visual = "S",
			visual_line = "gZ",
			delete = "ds",
			change = "cs",
		},
		aliases = {
			["a"] = ">",
			["p"] = ")",
			["c"] = "}",
			["b"] = "]",
			["q"] = { '"', "'", "`" },
			["s"] = { "}", "]", ")", ">", '"', "'", "`" },
		},
	})
end

return M
