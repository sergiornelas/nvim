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
		-- lines to seek forwards for "small" textobjs (most characterwise)
		-- set to 0 to only look in the current line
		lookForwardSmall = 5,
		-- lines to seek forwards for "big" textobjs
		-- (linewise textobjs and the url textobj)
		lookForwardBig = 15,
		useDefaultKeymaps = false,
	})

	local keymap = vim.keymap.set
	-- indentation (mini.indentscope does a better job)
	-- restOfIndentation not really that useful

	-- like iw, but treating -, _, and . as word delimiters and only part of camelCase
	keymap({ "o", "x" }, "iS", "<cmd>lua require('various-textobjs').subword(true)<cr>")
	keymap({ "o", "x" }, "aS", "<cmd>lua require('various-textobjs').subword(false)<cr>")

	-- from cursor to next closing ], ), or }
	keymap({ "o", "x" }, "ii", "<cmd>lua require('various-textobjs').toNextClosingBracket()<cr>")

	-- like }, but linewise
	keymap({ "o", "x" }, "ar", "<cmd>lua require('various-textobjs').restOfParagraph()<cr>")

	-- entire buffer as one text object
	keymap({ "o", "x" }, "gG", "<cmd>lua require('various-textobjs').entireBuffer()<cr>")

	-- from cursor position to end of line, minus one character
	keymap({ "o", "x" }, "n", "<cmd>lua require('various-textobjs').nearEoL()<cr>")

	-- current line, but characterwise
	keymap({ "o", "x" }, "i_", "<cmd>lua require('various-textobjs').lineCharacterwise(true)<cr>")
	keymap({ "o", "x" }, "a_", "<cmd>lua require('various-textobjs').lineCharacterwise(false)<cr>")

	-- column down until indent or shorter line. Accepts {count} for multiple columns.
	keymap({ "o", "x" }, "|", "<cmd>lua require('various-textobjs').column()<cr>")

	-- value of key-value pair, or right side of a variable assignment (inside one line)
	keymap({ "o", "x" }, "iv", "<cmd>lua require('various-textobjs').value(true)<cr>")
	keymap({ "o", "x" }, "av", "<cmd>lua require('various-textobjs').value(false)<cr>")

	-- key of key-value pair, or left side of a variable assignment
	keymap({ "o", "x" }, "ik", "<cmd>lua require('various-textobjs').key(true)<cr>")
	keymap({ "o", "x" }, "ak", "<cmd>lua require('various-textobjs').key(false)<cr>")

	-- link beginning with "http"
	keymap({ "o", "x" }, "U", "<cmd>lua require('various-textobjs').url()<cr>")

	-- LSP diagnostic (requires built-in LSP)
	keymap({ "o", "x" }, "!", "<cmd>lua require('various-textobjs').diagnostic()<cr>")

	-- closed fold
	keymap({ "o", "x" }, "iz", "<cmd>lua require('various-textobjs').closedFold(true)<cr>")
	keymap({ "o", "x" }, "az", "<cmd>lua require('various-textobjs').closedFold(false)<cr>")

	-- field with the full call, like .encode(param)
	keymap({ "o", "x" }, "im", "<cmd>lua require('various-textobjs').chainMember(true)<cr>")
	keymap({ "o", "x" }, "am", "<cmd>lua require('various-textobjs').chainMember(false)<cr>")

	-- all lines visible in the current window
	keymap({ "o", "x" }, "gw", "<cmd>lua require('various-textobjs').visibleInWindow()<cr>")

	-- from the cursorline to the last line in the window
	keymap({ "o", "x" }, "gW", "<cmd>lua require('various-textobjs').restOfWindow()<cr>")

	-- mdlink (markdown)
	-- mdFencedCodeBlock(markdown)

	-- class in CSS, like .my-class
	keymap({ "o", "x" }, "ic", "<cmd>lua require('various-textobjs').cssSelector(true)<cr>", { buffer = true })
	keymap({ "o", "x" }, "ac", "<cmd>lua require('various-textobjs').cssSelector(false)<cr>", { buffer = true })

	-- htmlAttribute (not useful)
	-- jsRegex (not useful (*))

	-- ext enclosed by [[]]
	keymap({ "o", "x" }, "iD", "<cmd>lua require('various-textobjs').doubleSquareBrackets(true)<cr>", { buffer = true })
	keymap(
		{ "o", "x" },
		"aD",
		"<cmd>lua require('various-textobjs').doubleSquareBrackets(false)<cr>",
		{ buffer = true }
	)

	-- shellPipe (zsh, fish)
end

return M
