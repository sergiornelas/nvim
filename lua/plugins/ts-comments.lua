local function comment_insert(open_key)
	local cs = vim.bo.commentstring
	if cs == "" then
		return
	end
	local prefix = cs:gsub("%%s.*", "")
	local keys = vim.api.nvim_replace_termcodes(open_key .. prefix, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end

return {
	"folke/ts-comments.nvim",
	opts = {},
	event = "VeryLazy",
	enabled = vim.fn.has("nvim-0.10.0") == 1,
	keys = {
		{ "gco", function() comment_insert("o") end },
		{ "gcO", function() comment_insert("O") end },
		{ "gcA", function() comment_insert("A ") end },
	},
}