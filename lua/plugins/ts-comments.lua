local jsx_filetypes = {
	javascriptreact = true,
	typescriptreact = true,
	javascript = true,
	typescript = true,
}

local function get_commentstring(lnum, col)
	if jsx_filetypes[vim.bo.filetype] then
		local ok, node = pcall(vim.treesitter.get_node, {
			ignore_injections = false,
			pos = { lnum, col },
		})
		while ok and node do
			local sr = node:start()
			local er = node:end_()
			if er > sr then
				local t = node:type()
				if t == "jsx_element" or t == "jsx_fragment" then
					return "{/* %s */}"
				end
				return "// %s"
			end
			node = node:parent()
		end
	end
	local ok2, comments = pcall(require, "ts-comments.comments")
	return ok2 and comments.get(vim.bo.filetype) or vim.bo.commentstring
end

local function comment_insert(open_key)
	local lnum = vim.fn.line(".")
	local line = vim.fn.getline(".")
	local indent = line:match("^%s*") or ""

	local pos_col = (open_key == "O") and 0 or #line
	local cs = get_commentstring(lnum - 1, pos_col)

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
