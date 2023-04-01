local M = {
	"chrisgrieser/nvim-various-textobjs",
	event = "BufReadPost",
}

function M.config()
	local textobjs_ok, textobjs = pcall(require, "various-textobjs")
	if not textobjs_ok then
		return
	end
	textobjs.setup({
		useDefaultKeymaps = false,
	})

	local keymap = vim.keymap.set
	-- indentation (mini.indentscope does a better job)
	-- restOfIndentation not really that useful

	keymap({ "o", "x" }, "iS", "<cmd>lua require('various-textobjs').subword(true)<CR>")
	keymap({ "o", "x" }, "aS", "<cmd>lua require('various-textobjs').subword(false)<CR>")

	keymap({ "o", "x" }, "ii", "<cmd>lua require('various-textobjs').toNextClosingBracket()<CR>")

	keymap({ "o", "x" }, "ar", "<cmd>lua require('various-textobjs').restOfParagraph()<CR>")

	keymap({ "o", "x" }, "gG", "<cmd>lua require('various-textobjs').entireBuffer()<CR>")

	keymap({ "o", "x" }, "n", "<cmd>lua require('various-textobjs').nearEoL()<CR>")

	keymap({ "o", "x" }, "_", "<cmd>lua require('various-textobjs').lineCharacterwise()<CR>")

	keymap({ "o", "x" }, "|", "<cmd>lua require('various-textobjs').column()<CR>")

	keymap({ "o", "x" }, "iv", "<cmd>lua require('various-textobjs').value(true)<CR>")
	keymap({ "o", "x" }, "av", "<cmd>lua require('various-textobjs').value(false)<CR>")

	keymap({ "o", "x" }, "ik", "<cmd>lua require('various-textobjs').key(true)<CR>")
	keymap({ "o", "x" }, "ak", "<cmd>lua require('various-textobjs').key(false)<CR>")

	keymap({ "o", "x" }, "U", "<cmd>lua require('various-textobjs').url()<CR>")

	keymap({ "o", "x" }, "in", "<cmd>lua require('various-textobjs').number(true)<CR>")
	keymap({ "o", "x" }, "an", "<cmd>lua require('various-textobjs').number(false)<CR>")

	keymap({ "o", "x" }, "!", "<cmd>lua require('various-textobjs').diagnostic()<CR>")

	-- mdlink (markdown)
	-- mdFencedCodeBlock(markdown)

	keymap({ "o", "x" }, "ic", "<cmd>lua require('various-textobjs').cssSelector(true)<CR>", { buffer = true })
	keymap({ "o", "x" }, "ac", "<cmd>lua require('various-textobjs').cssSelector(false)<CR>", { buffer = true })

	-- htmlAttribute (not useful)
	-- jsRegex (not useful (*))

	keymap({ "o", "x" }, "iD", "<cmd>lua require('various-textobjs').doubleSquareBrackets(true)<CR>", { buffer = true })
	keymap(
		{ "o", "x" },
		"aD",
		"<cmd>lua require('various-textobjs').doubleSquareBrackets(false)<CR>",
		{ buffer = true }
	)

	-- shellPipe (zsh, fish)
end

return M
