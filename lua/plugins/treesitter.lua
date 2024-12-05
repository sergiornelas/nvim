return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "BufReadPost",
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
				keymap({ "n", "x" }, "<leader>u", "<cmd>TSContextToggle<cr>", opts)
				keymap("i", "<c-g><c-t>", "<cmd>TSContextToggle<cr>", opts)
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
				local rainbow_delimiters = require("rainbow-delimiters")
				---@diagnostic disable-next-line: undefined-doc-name
				---@type rainbow_delimiters.config
				vim.g.rainbow_delimiters = {
					strategy = {
						[""] = rainbow_delimiters.strategy["global"],
						vim = rainbow_delimiters.strategy["local"],
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
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},
	config = function()
		local configs_ok, configs = pcall(require, "nvim-treesitter.configs")
		if not configs_ok then
			return
		end

		local map = vim.keymap.set
		local mode = { "n", "x", "o" }
		local illuminate = require("illuminate")
		local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
		local function goto_diagnostic(direction, error)
			local navigate = direction == "next" and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
			for _ = 1, vim.v.count1 do
				if error then
					navigate({ severity = vim.diagnostic.severity.ERROR, float = false })
				else
					navigate({ float = false })
				end
			end
		end

		local next_diagnostic, prev_diagnostic = ts_repeat_move.make_repeatable_move_pair(function()
			goto_diagnostic("next")
		end, function()
			goto_diagnostic("prev")
		end)
		local next_error, prev_error = ts_repeat_move.make_repeatable_move_pair(function()
			goto_diagnostic("next", true)
		end, function()
			goto_diagnostic("prev", true)
		end)
		local next_illuminate, prev_illuminate =
			ts_repeat_move.make_repeatable_move_pair(illuminate.goto_next_reference, illuminate.goto_prev_reference)
		local next_indentscope, prev_indentscope = ts_repeat_move.make_repeatable_move_pair(function()
			vim.cmd("normal " .. vim.v.count1 .. "[-")
		end, function()
			vim.cmd("normal " .. vim.v.count1 .. "]-")
		end)

		-- TODO
		-- local next_spell, prev_spell = ts_repeat_move.make_repeatable_move_pair(function()
		-- 	vim.cmd("normal " .. vim.v.count1 .. "[s")
		-- end, function()
		-- 	vim.cmd("normal " .. vim.v.count1 .. "]s")
		-- end)

		-- Repeatable move mappings
		map(mode, ";", ts_repeat_move.repeat_last_move)
		map(mode, ",", ts_repeat_move.repeat_last_move_opposite)
		map(mode, "f", ts_repeat_move.builtin_f_expr, { expr = true })
		map(mode, "F", ts_repeat_move.builtin_F_expr, { expr = true })
		map(mode, "t", ts_repeat_move.builtin_t_expr, { expr = true })
		map(mode, "T", ts_repeat_move.builtin_T_expr, { expr = true })

		-- Navigation mappings
		map(mode, "]e", next_error)
		map(mode, "[e", prev_error)
		map(mode, "]d", next_diagnostic) -- (vim: go to prev diagnostic no float w. (nvim 0.10))
		map(mode, "[d", prev_diagnostic) -- (vim: go to next diagnostic no float w. (nvim 0.10))
		map(mode, "]w", next_illuminate)
		map(mode, "[w", prev_illuminate)
		map(mode, "[t", next_indentscope)
		map(mode, "]t", prev_indentscope)
		-- map(mode, "[s", next_spell)
		-- map(mode, "]s", prev_spell)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "markdown" },
			callback = function()
				local keymap_opts = { noremap = true, silent = true, buffer = vim.api.nvim_get_current_buf() }
				local next_md_header, prev_md_header = ts_repeat_move.make_repeatable_move_pair(function()
					vim.cmd("silent! /^##\\+\\s.*$")
					vim.cmd("nohlsearch")
				end, function()
					vim.cmd("silent! ?^##\\+\\s.*$")
					vim.cmd("nohlsearch")
				end)
				map(mode, "]e", next_md_header, keymap_opts)
				map(mode, "[e", prev_md_header, keymap_opts)
			end,
		})

		configs.setup({
			ensure_installed = {
				"bash",
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
			},
			sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
			auto_install = true,
			ignore_install = { "" }, -- List of parsers to ignore installing
			highlight = {
				enable = true, -- false will disable the whole extension
				disable = { "" }, -- list of language that will be disabled
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
			autopairs = { --automatic ({[]})
				enable = true,
			},
			autotag = { --HTML/JSX tags autorename
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = false,
					scope_incremental = false,
					node_incremental = "<c-r>",
					node_decremental = "<c-t>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					-- You have to clear all mappings in the buffer to test updated mappings:
					-- :mapclear <buffer>
					keymaps = {
						["ia"] = "@parameter.inner",
						["aa"] = "@parameter.outer",
						["ic"] = "@conditional.inner",
						["ac"] = "@conditional.outer",
						["if"] = "@function.inner",
						["af"] = "@function.outer",
						-- ["ig"] = "@call.inner",
						-- ["ag"] = "@call.outer",
						["ak"] = "@comment.outer",
						["ir"] = "@number.inner",
						["at"] = "@assignment.outer",
						["in"] = "@assignment.lhs",
						["iv"] = "@assignment.rhs",
						["ix"] = "@loop.inner",
						["ax"] = "@loop.outer",
					},
					selection_modes = {
						["@function.outer"] = "V",
						["@conditional.outer"] = "V",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>."] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>,"] = "@parameter.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]a"] = "@parameter.inner",
						["]c"] = "@conditional.outer", -- (vim: cursor N times forward to start of change)
						["]f"] = "@function.outer", -- (vim: same as "gf")
						["]g"] = "@call.outer",
						["]k"] = "@comment.outer",
						["]n"] = "@assignment.lhs",
						["]r"] = "@number.inner",
						["]v"] = "@assignment.rhs",
						["]o"] = "@loop.outer",
					},
					goto_next_end = {
						["]A"] = "@parameter.inner",
						["]C"] = "@conditional.outer",
						["]F"] = "@function.outer",
						["]G"] = "@call.outer",
						["]K"] = "@comment.outer",
						["]N"] = "@assignment.lhs",
						["]R"] = "@number.inner",
						["]V"] = "@assignment.rhs",
						["]O"] = "@loop.outer",
					},
					goto_previous_start = {
						["[a"] = "@parameter.inner",
						["[c"] = "@conditional.outer", -- (vim: cursor N times backwards to start of change)
						["[f"] = "@function.outer", -- (vim: same as "gf")
						["[g"] = "@call.outer",
						["[k"] = "@comment.outer",
						["[n"] = "@assignment.lhs",
						["[r"] = "@number.inner",
						["[v"] = "@assignment.rhs",
						["[o"] = "@loop.outer",
					},
					goto_previous_end = {
						["[A"] = "@parameter.inner",
						["[C"] = "@conditional.outer",
						["[F"] = "@function.outer",
						["[G"] = "@call.outer",
						["[K"] = "@comment.outer",
						["[N"] = "@assignment.lhs",
						["[R"] = "@number.inner",
						["[V"] = "@assignment.rhs",
						["[O"] = "@loop.outer",
					},
				},
				lsp_interop = {
					enable = true,
					border = "single",
					floating_preview_opts = {},
					peek_definition_code = {
						["<leader>v"] = "@function.outer",
					},
				},
			},
		})
	end,
}
