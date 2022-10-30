local nvim_surround_ok, nvim_surround = pcall(require, "nvim-surround")
if not nvim_surround_ok then
	return
end

nvim_surround.setup({
	keymaps = {
		insert = "<C-x>s",
		insert_line = "<C-x>S",
		normal = "dm",
		normal_cur = "dmm",
		normal_line = "dM",
		normal_cur_line = "dMM",
		visual = "Z",
		visual_line = "gZ",
		delete = "ds",
		change = "cs",
	},
	aliases = {
		["a"] = ">",
		["f"] = ")",
		["e"] = "}",
		["w"] = "]",
		["q"] = { '"', "'", "`" },
		["s"] = { "}", "]", ")", ">", '"', "'", "`" },
	},
})
