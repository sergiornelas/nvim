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
	keymap({ "o", "x" }, "iv", function()
		textobjs.value(true)
	end)
	keymap({ "o", "x" }, "av", function()
		textobjs.value(false)
	end)

	keymap({ "o", "x" }, "ik", function()
		textobjs.key(true)
	end)
	keymap({ "o", "x" }, "ak", function()
		textobjs.key(false)
	end)

	keymap({ "o", "x" }, "in", function()
		textobjs.number(true)
	end)
	keymap({ "o", "x" }, "an", function()
		textobjs.number(false)
	end)

	keymap({ "o", "x" }, "?", function()
		textobjs.diagnostic()
	end)

	keymap({ "o", "x" }, "n", function()
		textobjs.nearEoL()
	end)

	keymap({ "o", "x" }, "ic", function()
		textobjs.cssSelector(true)
	end)
	keymap({ "o", "x" }, "ac", function()
		textobjs.cssSelector(false)
	end)

	keymap({ "o", "x" }, "iD", function()
		textobjs.doubleSquareBrackets(true)
	end)
	keymap({ "o", "x" }, "aD", function()
		textobjs.doubleSquareBrackets(false)
	end)

	keymap({ "o", "x" }, "|", function()
		textobjs.column()
	end)

	keymap({ "o", "x" }, "r", function()
		textobjs.restOfParagraph()
	end)

	keymap({ "o", "x" }, "iS", function()
		textobjs.subword(true)
	end)
	keymap({ "o", "x" }, "aS", function()
		textobjs.subword(false)
	end)

	keymap({ "o", "x" }, "gG", function()
		textobjs.entireBuffer()
	end)

	keymap({ "o", "x" }, "U", function()
		textobjs.url()
	end)
end

return M
