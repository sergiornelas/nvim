return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "BufReadPost",
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-context",
			cond = not vim.g.vscode,
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
			cond = not vim.g.vscode,
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
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		{
			"mawkler/jsx-element.nvim",
			ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
			opts = {
				keymaps = {
					jsx_element = "j",
				},
			},
		},
	},
	config = function()
		local configs_ok, configs = pcall(require, "nvim-treesitter.configs")
		if not configs_ok then
			return
		end

		local map = vim.keymap.set
		local mode = { "n", "x", "o" }
		local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
		local function safe_fix_nav(command)
			return function()
				if not pcall(vim.api.nvim_command, vim.v.count1 .. command) then
					print("No more items")
				end
			end
		end

		local next_diagnostic, prev_diagnostic = ts_repeat_move.make_repeatable_move_pair(function()
			vim.diagnostic.jump({ count = vim.v.count1 })
		end, function()
			vim.diagnostic.jump({ count = -vim.v.count1 })
		end)
		local next_error, prev_error = ts_repeat_move.make_repeatable_move_pair(function()
			if vim.g.vscode then
				vim.fn.VSCodeNotify("editor.action.marker.next")
			else
				vim.diagnostic.jump({ count = vim.v.count1, severity = vim.diagnostic.severity.ERROR })
			end
		end, function()
			if vim.g.vscode then
				vim.fn.VSCodeNotify("editor.action.marker.prev")
			else
				vim.diagnostic.jump({ count = -vim.v.count1, severity = vim.diagnostic.severity.ERROR })
			end
		end)
		local next_indentscope, prev_indentscope = ts_repeat_move.make_repeatable_move_pair(function()
			vim.cmd("normal " .. vim.v.count1 .. "[-")
		end, function()
			vim.cmd("normal " .. vim.v.count1 .. "]-")
		end)
		local next_quickfix_el, prev_quickfix_el =
			ts_repeat_move.make_repeatable_move_pair(safe_fix_nav("cnext"), safe_fix_nav("cprev"))
		local next_loclist_el, prev_loclist_el =
			ts_repeat_move.make_repeatable_move_pair(safe_fix_nav("lne"), safe_fix_nav("lp"))
		local next_spell, prev_spell = ts_repeat_move.make_repeatable_move_pair(function()
			vim.cmd("normal! " .. vim.v.count1 .. "[s")
		end, function()
			vim.cmd("normal! " .. vim.v.count1 .. "]s")
		end)
		local next_buffer, prev_buffer = ts_repeat_move.make_repeatable_move_pair(function()
			require("buftrack").next_buffer()
		end, function()
			require("buftrack").prev_buffer()
		end)
		local move_down, move_up = ts_repeat_move.make_repeatable_move_pair(function()
			vim.cmd("normal " .. vim.v.count1 .. "]+")
		end, function()
			vim.cmd("normal " .. vim.v.count1 .. "[+")
		end)

		-- Repeatable move mappings
		map(mode, ";", ts_repeat_move.repeat_last_move)
		map(mode, ",", ts_repeat_move.repeat_last_move_opposite)
		map(mode, "f", ts_repeat_move.builtin_f_expr, { expr = true })
		map(mode, "F", ts_repeat_move.builtin_F_expr, { expr = true })
		map(mode, "t", ts_repeat_move.builtin_t_expr, { expr = true })
		map(mode, "T", ts_repeat_move.builtin_T_expr, { expr = true })

		-- Navigation mappings
		map(mode, "]q", next_quickfix_el) -- (vim: go to next quickfix item (v0.11))
		map(mode, "[q", prev_quickfix_el) -- (vim: go to prev quickfix item (v0.11))
		map(mode, "]l", next_loclist_el) -- (vim: go to next loclist item (v0.11))
		map(mode, "[l", prev_loclist_el) -- (vim: go to prev loclist item (v0.11))
		map(mode, "]e", next_error)
		map(mode, "[e", prev_error)
		map(mode, "]d", next_diagnostic) -- (vim: go to prev diagnostic no float window (v0.10))
		map(mode, "[d", prev_diagnostic) -- (vim: go to next diagnostic no float window (v0.10))
		map(mode, "[t", next_indentscope) -- (vim: next tag (v0.11))
		map(mode, "]t", prev_indentscope) -- (vim: prev tag (v0.11))
		map(mode, "[s", next_spell) -- (vim: move to the previous misspelled word)
		map(mode, "]s", prev_spell) -- (vim: move to the next misspelled word)
		map(mode, "]b", next_buffer) -- (vim: next buffer element in list (v0.11))
		map(mode, "[b", prev_buffer) -- (vim: prev buffer element in list (v0.11))
		map(mode, "]r", move_down)
		map(mode, "[r", move_up)

		-- navigate through markdown headers
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "markdown" },
			callback = function()
				local keymap_opts = { noremap = true, silent = true, buffer = vim.api.nvim_get_current_buf() }
				local next_md_header, prev_md_header = ts_repeat_move.make_repeatable_move_pair(function()
					vim.cmd([[call search('\%(^#\{1,5}\s\+\S\|^\S.*\n^[=-]\+$\)', 'sW')]])
				end, function()
					vim.cmd([[call search('\%(^#\{1,5}\s\+\S\|^\S.*\n^[=-]\+$\)', 'bsW')]])
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
						["]a"] = "@parameter.inner", -- (vim: next argument list (v0.11)
						["]k"] = "@conditional.outer", -- (vim: cursor N times forward to start of change)
						["]f"] = "@function.outer", -- (vim: same as "gf")
						["]g"] = "@call.outer",
						["]c"] = "@comment.outer",
						["]w"] = "@assignment.lhs",
						["]o"] = "@loop.outer",
						["]x"] = "@number.inner",
						["]v"] = "@assignment.rhs",
					},
					goto_next_end = {
						["]A"] = "@parameter.inner", -- (vim: last argument list (v0.11)
						["]K"] = "@conditional.outer",
						["]F"] = "@function.outer",
						["]G"] = "@call.outer",
						["]C"] = "@comment.outer",
						["]W"] = "@assignment.lhs",
						["]O"] = "@loop.outer",
						["]X"] = "@number.inner",
						["]V"] = "@assignment.rhs",
					},
					goto_previous_start = {
						["[a"] = "@parameter.inner", -- (vim: prev argument list (v0.11)
						["[k"] = "@conditional.outer", -- (vim: cursor N times backwards to start of change)
						["[f"] = "@function.outer", -- (vim: same as "gf")
						["[g"] = "@call.outer",
						["[c"] = "@comment.outer",
						["[w"] = "@assignment.lhs",
						["[o"] = "@loop.outer",
						["[x"] = "@number.inner",
						["[v"] = "@assignment.rhs",
					},
					goto_previous_end = {
						["[A"] = "@parameter.inner", -- (vim: first argument list (v0.11)
						["[K"] = "@conditional.outer",
						["[F"] = "@function.outer",
						["[G"] = "@call.outer",
						["[C"] = "@comment.outer",
						["[W"] = "@assignment.lhs",
						["[O"] = "@loop.outer",
						["[X"] = "@number.inner",
						["[V"] = "@assignment.rhs",
					},
				},
				lsp_interop = {
					enable = true,
					border = "single",
					floating_preview_opts = {},
					peek_definition_code = {
						["<leader>K"] = "@function.outer",
					},
				},
			},
		})
	end,
}
