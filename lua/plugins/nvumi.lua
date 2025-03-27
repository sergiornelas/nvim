return {
	-- brew install nikolaeu/numi/numi-cli
	"josephburgess/nvumi",
	dependencies = { "folke/snacks.nvim" },
	keys = {
		{
			"<leader>m",
			"<cmd>Nvumi<cr>",
		},
	},
	opts = {
		virtual_text = "inline", -- "newline"
		prefix = "= ",
		date_format = "uk", -- uk, us, long
		keys = {
			run = "<c-j>",
			reset = "<c-c><c-c>",
			yank = "<leader>y",
			yank_all = "<leader>Y",
		},
		custom_functions = {
			{
				def = { phrases = "yield" },
				fn = function(amount, _)
					if #amount < 1 or type(amount[1]) ~= "number" then
						return { error = "requires two numeric argument" }
					end
					return { result = (amount[1] * amount[2]) / 100 }
				end,
			},
		},
	},
}
