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
			insert = "<c-s><c-j>",
			insert_line = "<c-s><c-s>",
			--
			normal = "<c-s><c-j>",
			normal_line = "<c-s><c-s>",
			normal_cur = "<c-s>l",
			normal_cur_line = "<c-s>L",
			--
			visual = "<c-s><c-j>",
			visual_line = "<c-s><c-s>",
			--
			delete = "ds",
			--
			change = "cs",
			change_line = "cS",
		},
		aliases = {
			["a"] = ">",
			["p"] = ")",
			["c"] = "}",
			["b"] = "]",
			["q"] = "'",
			["s"] = { "}", "]", ")", ">", '"', "'", "`" },
		},
	})
end

return M
