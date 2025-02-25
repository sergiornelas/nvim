return {
	"kevinhwang91/nvim-hlslens",
	keys = {
		{
			"n",
		},
		{
			"N",
		},
		{
			"*",
		},
		{
			"#",
		},
		{
			"g*",
		},
		{
			"g#",
		},
		{
			"/",
		},
		{
			"?",
		},
	},
	config = function()
		require("hlslens").setup({
			calm_down = {
				default = true,
			},
			nearest_only = {
				default = true,
			},
			nearest_float_when = {
				default = "never",
			},
		})

		local opts = { noremap = true, silent = true }
		local map = vim.keymap.set
		map("n", "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], opts)
		map("n", "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], opts)
		map("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], opts)
		map("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], opts)
		map("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], opts)
		map("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], opts)
	end,
}
