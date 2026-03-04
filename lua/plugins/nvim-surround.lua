return {
	"kylechui/nvim-surround",
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
	config = function()
		require("nvim-surround").setup({
			aliases = {
				["a"] = ">",
				["p"] = ")",
				["c"] = "}",
				["b"] = "]",
				["q"] = "'",
				["s"] = { "}", "]", ")", ">", '"', "'", "`" }, -- dss
			},
		})

		local function map_surround(mode, lhs, plug, desc)
			vim.keymap.set(mode, lhs, plug, {
				silent = true,
				desc = desc,
			})
		end

		-- Insert
		map_surround("i", "<c-s>", "<Plug>(nvim-surround-insert)", "Add surround (insert)") -- (vim: toggles vim.lsp.buf.signature_help() (v0.11), handled by blink.cmp)
		map_surround("i", "<c-s><c-s>", "<Plug>(nvim-surround-insert-line)", "Add surround on new lines (insert)") -- (vim: toggles vim.lsp.buf.signature_help() (v0.11), handled by blink.cmp)

		-- Normal
		map_surround("n", "<c-s>", "<Plug>(nvim-surround-normal)", "Add surround (motion)") -- (vim: not used, or used for terminal control flow)
		map_surround("n", "<c-s>c", "<Plug>(nvim-surround-normal-cur)", "Add surround (current)") -- (vim: not used, or used for terminal control flow)
		map_surround("n", "<c-s><c-s>", "<Plug>(nvim-surround-normal-line)", "Add surround on new lines (motion)") -- (vim: not used, or used for terminal control flow)
		map_surround("n", "<c-s>C", "<Plug>(nvim-surround-normal-cur-line)", "Add surround on new lines (current)") -- (vim: not used, or used for terminal control flow)

		-- Visual
		map_surround("x", "<c-s>", "<Plug>(nvim-surround-visual)", "Add surround (visual)")
		map_surround("x", "<c-s><c-s>", "<Plug>(nvim-surround-visual-line)", "Add surround on new lines (visual)")

		-- Delete / Change
		map_surround("n", "ds", "<Plug>(nvim-surround-delete)", "Delete surround")
		map_surround("n", "cs", "<Plug>(nvim-surround-change)", "Change surround")
		map_surround("n", "cS", "<Plug>(nvim-surround-change-line)", "Change surround on new lines")
	end,
}
