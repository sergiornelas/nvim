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

	-- like iw, but treating -, _, and . as word delimiters and only part of camelCase
	keymap({ "o", "x" }, "iS", "<cmd>lua require('various-textobjs').subword(true)<CR>")
	keymap({ "o", "x" }, "aS", "<cmd>lua require('various-textobjs').subword(false)<CR>")

	-- from cursor to next closing ], ), or }
	keymap({ "o", "x" }, "ii", "<cmd>lua require('various-textobjs').toNextClosingBracket()<CR>")

	-- like }, but linewise
	keymap({ "o", "x" }, "ar", "<cmd>lua require('various-textobjs').restOfParagraph()<CR>")

	-- entire buffer as one text object
	keymap({ "o", "x" }, "gG", "<cmd>lua require('various-textobjs').entireBuffer()<CR>")

	-- from cursor position to end of line, minus one character
	keymap({ "o", "x" }, "n", "<cmd>lua require('various-textobjs').nearEoL()<CR>")

	-- current line, but characterwise
	keymap({ "o", "x" }, "_", "<cmd>lua require('various-textobjs').lineCharacterwise()<CR>")

	-- column down until indent or shorter line. Accepts {count} for multiple columns.
	keymap({ "o", "x" }, "|", "<cmd>lua require('various-textobjs').column()<CR>")

	-- value of key-value pair, or right side of a variable assignment (inside one line)
	keymap({ "o", "x" }, "iv", "<cmd>lua require('various-textobjs').value(true)<CR>")
	keymap({ "o", "x" }, "av", "<cmd>lua require('various-textobjs').value(false)<CR>")

	-- key of key-value pair, or left side of a variable assignment
	keymap({ "o", "x" }, "ik", "<cmd>lua require('various-textobjs').key(true)<CR>")
	keymap({ "o", "x" }, "ak", "<cmd>lua require('various-textobjs').key(false)<CR>")

	-- link beginning with "http"
	keymap({ "o", "x" }, "U", "<cmd>lua require('various-textobjs').url()<CR>")

	-- numbers, similar to <C-a>
	keymap({ "o", "x" }, "in", "<cmd>lua require('various-textobjs').number(true)<CR>")
	keymap({ "o", "x" }, "an", "<cmd>lua require('various-textobjs').number(false)<CR>")

	-- LSP diagnostic (requires built-in LSP)
	keymap({ "o", "x" }, "!", "<cmd>lua require('various-textobjs').diagnostic()<CR>")

	-- closed fold
	keymap({ "o", "x" }, "iz", "<cmd>lua require('various-textobjs').closedFold(true)<CR>")
	keymap({ "o", "x" }, "az", "<cmd>lua require('various-textobjs').closedFold(false)<CR>")

	-- field with the full call, like .encode(param)
	keymap({ "o", "x" }, "im", "<cmd>lua require('various-textobjs').chainMember(true)<CR>")
	keymap({ "o", "x" }, "am", "<cmd>lua require('various-textobjs').chainMember(false)<CR>")

	-- mdlink (markdown)
	-- mdFencedCodeBlock(markdown)

	-- class in CSS, like .my-class
	keymap({ "o", "x" }, "ic", "<cmd>lua require('various-textobjs').cssSelector(true)<CR>", { buffer = true })
	keymap({ "o", "x" }, "ac", "<cmd>lua require('various-textobjs').cssSelector(false)<CR>", { buffer = true })

	-- htmlAttribute (not useful)
	-- jsRegex (not useful (*))

	-- ext enclosed by [[]]
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
