local M = {
	"kylechui/nvim-surround",
	version = "*",
	keys = {
		{
			"<c-s>",
			mode = { "n", "x", "i" },
		},
		{
			"ds",
		},
		{
			"cs",
		},
		{
			"cS",
		},
	},
}

function M.config()
	local nvim_surround_ok, nvim_surround = pcall(require, "nvim-surround")
	if not nvim_surround_ok then
		return
	end

	nvim_surround.setup({
		keymaps = {
			insert = "<c-s>", -- (vim: toggles vim.lsp.buf.signature_help() (v0.11), handled by blink.cmp)
			insert_line = "<c-s><c-s>", -- (vim: toggles vim.lsp.buf.signature_help() (v0.11), handled by blink.cmp)
			--
			normal = "<c-s>", -- (vim: not used, or used for terminal control flow)
			normal_line = "<c-s><c-s>", -- (vim: not used, or used for terminal control flow)
			normal_cur = "<c-s>c", -- (vim: not used, or used for terminal control flow)
			normal_cur_line = "<c-s>C", -- (vim: not used, or used for terminal control flow)
			--
			visual = "<c-s>",
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
