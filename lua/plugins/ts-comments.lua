local function comment_insert(open_key)
	local original_pos = vim.api.nvim_win_get_cursor(0)
	local line = vim.fn.getline(".")
	local indent = line:match("^%s*") or ""
	pcall(vim.api.nvim_win_set_cursor, 0, { original_pos[1], #indent })

	local ok, comments = pcall(require, "ts-comments.comments")
	local cs = ok and comments.get(vim.bo.filetype) or vim.bo.commentstring

	pcall(vim.api.nvim_win_set_cursor, 0, original_pos)

	if not cs or cs == "" then
		return
	end
	local left, right = cs:match("^(.-)%s*%%s%s*(.*)$")
	if not left then
		return
	end
	left = left .. " "
	right = right ~= "" and (" " .. right) or ""
	local text = left .. right
	local back = right ~= "" and string.rep("<Left>", #right) or ""

	local indent_fix = ""
	if open_key == "o" or open_key == "O" then
		indent_fix = "<C-u>" .. indent
	end

	local keys = vim.api.nvim_replace_termcodes(open_key .. indent_fix .. text .. back, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end

return {
	"folke/ts-comments.nvim",
	opts = {},
	event = "VeryLazy",
	enabled = vim.fn.has("nvim-0.10.0") == 1,
	keys = {
		{
			"gco",
			function()
				comment_insert("o")
			end,
		},
		{
			"gcO",
			function()
				comment_insert("O")
			end,
		},
		{
			"gcA",
			function()
				comment_insert("A ")
			end,
		},
	},
}
