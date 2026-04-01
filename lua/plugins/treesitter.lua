-- npm install -g tree-sitter-cli
return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			"bash",
			"comment", -- todo highlight
			"css",
			"html",
			"javascript",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"regex",
			"scss",
			"styled",
			"tmux",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"yaml",
		})
	end,
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-context",
			config = function()
				require("treesitter-context").setup({
					enable = true,
					max_lines = 0,
					line_numbers = true,
					multiline_threshold = 20,
				})
				local keymap = vim.keymap.set
				local opts = { noremap = true, silent = true }
				keymap({ "n", "x" }, "<leader>c", "<cmd>TSContext toggle <cr>", opts)
				keymap("n", "<leader>t0", "<cmd>lua require('treesitter-context').go_to_context(1)<cr>", opts)
				for i = 1, 9 do
					local cmd = "<cmd>lua require('treesitter-context').go_to_context(" .. i .. ")<cr>"
					keymap("n", "<leader>t" .. i, cmd, opts)
				end
				keymap("n", "<leader>tu", "<cmd>lua require('treesitter-context').go_to_context(99)<cr>", opts)
			end,
		},
		{
			"hiphish/rainbow-delimiters.nvim",
			config = function()
				vim.g.rainbow_delimiters = {
					strategy = {
						[""] = "rainbow-delimiters.strategy.global",
						vim = "rainbow-delimiters.strategy.local",
					},
					query = {
						[""] = "rainbow-delimiters",
						lua = "rainbow-blocks",
					},
					priority = {
						[""] = 110,
						lua = 210,
					},
					highlight = {
						"RainbowDelimiterRed",
						"RainbowDelimiterYellow",
						"RainbowDelimiterBlue",
						"RainbowDelimiterOrange",
						"RainbowDelimiterGreen",
						"RainbowDelimiterViolet",
						"RainbowDelimiterCyan",
					},
				}
			end,
		},
		-- {
		-- 	"mawkler/jsx-element.nvim",
		-- 	ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		-- 	opts = {
		-- 		keymaps = {
		-- 			jsx_element = "j",
		-- 		},
		-- 	},
		-- },
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			branch = "main",
			init = function()
				-- Disable entire built-in ftplugin mappings to avoid conflicts.
				-- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
				vim.g.no_plugin_maps = true
			end,
			config = function()
				require("nvim-treesitter-textobjects").setup({
					move = {
						-- whether to set jumps in the jumplist
						set_jumps = true,
					},
				})

				local function map(mode, key, command)
					vim.keymap.set(mode, key, command, { noremap = true, silent = true })
				end
				local select = require("nvim-treesitter-textobjects.select").select_textobject
				local swap = require("nvim-treesitter-textobjects.swap")
				local move = require("nvim-treesitter-textobjects.move")

				-- select
				map({ "x", "o" }, "ia", function()
					select("@parameter.inner", "textobjects")
				end)
				map({ "x", "o" }, "aa", function()
					select("@parameter.outer", "textobjects")
				end)
				map({ "x", "o" }, "ic", function()
					select("@conditional.inner", "textobjects")
				end)
				map({ "x", "o" }, "ac", function()
					select("@conditional.outer", "textobjects")
				end)
				map({ "x", "o" }, "if", function()
					select("@function.inner", "textobjects")
				end)
				map({ "x", "o" }, "af", function()
					select("@function.outer", "textobjects")
				end)
				-- map({ "x", "o" }, "ig", function()
				-- 	textobj("@call.inner", "textobjects")
				-- end)
				-- map({ "x", "o" }, "ag", function()
				-- 	textobj("@call.outer", "textobjects")
				-- end)
				map({ "x", "o" }, "ak", function()
					select("@comment.outer", "textobjects")
				end)
				map({ "x", "o" }, "ir", function()
					select("@number.inner", "textobjects")
				end)
				-- map({ "x", "o" }, "at", function() -- we use 'at' for html/jsx/tsx elements
				-- 	select("@assignment.outer", "textobjects")
				-- end)
				map({ "x", "o" }, "in", function()
					select("@assignment.lhs", "textobjects")
				end)
				map({ "x", "o" }, "iv", function()
					select("@assignment.rhs", "textobjects")
				end)
				map({ "x", "o" }, "ix", function()
					select("@loop.inner", "textobjects")
				end)
				map({ "x", "o" }, "ax", function()
					select("@loop.outer", "textobjects")
				end)

				-- swap
				map("n", "<leader>.", function()
					swap.swap_next("@parameter.inner")
				end)
				map("n", "<leader>,", function()
					swap.swap_previous("@parameter.inner")
				end)

				-- move
				local textobjects = {
					a = "@parameter.inner", -- (vim: next/last/prev/first argument list (v0.11)
					k = "@conditional.outer", -- (vim: cursor N times forward/backwards to start of change)
					f = "@function.outer", -- (vim: same as "gf")
					g = "@call.outer",
					c = "@comment.outer",
					w = "@assignment.lhs",
					o = "@loop.outer",
					x = "@number.inner",
					v = "@assignment.rhs",
				}

				local motions = {
					next_start = { fn = move.goto_next_start, prefix = "]", upper = false },
					next_end = { fn = move.goto_next_end, prefix = "]", upper = true },
					prev_start = { fn = move.goto_previous_start, prefix = "[", upper = false },
					prev_end = { fn = move.goto_previous_end, prefix = "[", upper = true },
				}

				for _, motion in pairs(motions) do
					for key, query in pairs(textobjects) do
						local k = motion.upper and key:upper() or key
						local lhs = motion.prefix .. k

						map({ "n", "x", "o" }, lhs, function()
							motion.fn(query, "textobjects")
						end)
					end
				end
			end,
		},
	},
}
