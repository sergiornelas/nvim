return {
	"kiyoon/repeatable-move.nvim",
	lazy = false,
	dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
	config = function()
		local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

		local map = vim.keymap.set
		local mode = { "n", "x", "o" }
		-- free: [b

		-- Repeat movement with ; and ,
		-- ensure ; goes forward and , goes backward regardless of the last direction
		-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
		-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

		-- vim way: ; goes to the direction you were moving.
		map(mode, ";", ts_repeat_move.repeat_last_move)
		map(mode, ",", ts_repeat_move.repeat_last_move_opposite)

		-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
		map(mode, "f", ts_repeat_move.builtin_f_expr, { expr = true })
		map(mode, "F", ts_repeat_move.builtin_F_expr, { expr = true })
		map(mode, "t", ts_repeat_move.builtin_t_expr, { expr = true })
		map(mode, "T", ts_repeat_move.builtin_T_expr, { expr = true })

		local repeat_move = require("repeatable_move")

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local next_warn = function()
					vim.diagnostic.jump({ count = vim.v.count1 })
				end
				local prev_warn = function()
					vim.diagnostic.jump({ count = -vim.v.count1 })
				end
				local next_err = function()
					vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
				end
				local prev_err = function()
					vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
				end

				-- make sure forward function comes first
				next_warn, prev_warn = repeat_move.make_repeatable_move_pair(next_warn, prev_warn)
				next_err, prev_err = repeat_move.make_repeatable_move_pair(next_err, prev_err)

				local opts = { buffer = args.buf }
				map(mode, "]d", next_warn, vim.tbl_extend("force", opts, { desc = "Next warning" })) -- (vim: go to prev diagnostic no float window (v0.10))
				map(mode, "[d", prev_warn, vim.tbl_extend("force", opts, { desc = "Previous warning" })) -- (vim: go to next diagnostic no float window (v0.10))
				map(mode, "]e", next_err, vim.tbl_extend("force", opts, { desc = "Next error" }))
				map(mode, "[e", prev_err, vim.tbl_extend("force", opts, { desc = "Previous error" }))
			end,
		})

		-- ----------------
		local function jump_list(list_type, cmd)
			local has_items = list_type == "qf" and vim.fn.len(vim.fn.getqflist()) > 0
				or list_type == "ll" and vim.fn.len(vim.fn.getloclist(0)) > 0
			if has_items then
				local ok = pcall(function()
					vim.cmd(cmd .. " " .. vim.v.count1)
				end)
				if not ok then
					vim.notify(
						"No more " .. (list_type == "qf" and "quickfix" or "locallist") .. " items",
						vim.log.levels.WARN
					)
				end
			else
				vim.notify("No " .. (list_type == "qf" and "quickfix" or "locallist") .. " items", vim.log.levels.WARN)
			end
		end
		local qf_next_repeat, qf_prev_repeat = repeat_move.make_repeatable_move_pair(function()
			jump_list("qf", "cnext")
		end, function()
			jump_list("qf", "cprev")
		end)
		map("n", "]q", qf_next_repeat) -- (vim: go to next quickfix item (v0.11))
		map("n", "[q", qf_prev_repeat) -- (vim: go to prev quickfix item (v0.11))
		local ll_next_repeat, ll_prev_repeat = repeat_move.make_repeatable_move_pair(function()
			jump_list("ll", "lnext")
		end, function()
			jump_list("ll", "lprev")
		end)
		map("n", "]l", ll_next_repeat) -- (vim: go to next loclist item (v0.11))
		map("n", "[l", ll_prev_repeat) -- (vim: go to prev loclist item (v0.11))

		-- ----------------
		local function indent_scope(cmd)
			vim.cmd("normal " .. vim.v.count1 .. cmd)
		end
		local next_indentscope, prev_indentscope = repeat_move.make_repeatable_move_pair(function()
			indent_scope("[-")
		end, function()
			indent_scope("]-")
		end)
		map(mode, "[t", next_indentscope) -- (vim: next tag (v0.11))
		map(mode, "]t", prev_indentscope) -- (vim: prev tag (v0.11))

		-- ----------------
		local function with_spell(cmd)
			if vim.wo.spell then
				vim.cmd("normal! " .. vim.v.count1 .. cmd)
			else
				vim.notify("Spell not enabled")
			end
		end
		local next_spell, prev_spell = repeat_move.make_repeatable_move_pair(function()
			with_spell("[s")
		end, function()
			with_spell("]s")
		end)
		map(mode, "[s", next_spell) -- (vim: move to the previous misspelled word)
		map(mode, "]s", prev_spell) -- (vim: move to the next misspelled word)

		-- ----------------
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "markdown" },
			callback = function()
				local keymap_opts = { noremap = true, silent = true, buffer = vim.api.nvim_get_current_buf() }
				local next_md_header, prev_md_header = repeat_move.make_repeatable_move_pair(function()
					vim.cmd([[call search('\%(^#\{1,5}\s\+\S\|^\S.*\n^[=-]\+$\)', 'sW')]])
				end, function()
					vim.cmd([[call search('\%(^#\{1,5}\s\+\S\|^\S.*\n^[=-]\+$\)', 'bsW')]])
				end)
				map(mode, "]e", next_md_header, keymap_opts)
				map(mode, "[e", prev_md_header, keymap_opts)
			end,
		})

		-- ----------------
		local move_down, move_up = repeat_move.make_repeatable_move_pair(function()
			vim.cmd("normal " .. vim.v.count1 .. "]+")
		end, function()
			vim.cmd("normal " .. vim.v.count1 .. "[+")
		end)
		map(mode, "]r", move_down)
		map(mode, "[r", move_up)

		-- ----------------
		-- free: visual mode <c-r>/<c-t>
		local function has_ts()
			return vim.treesitter.get_parser(nil, nil, { error = false }) ~= nil
		end
		local select_parent, select_child = repeat_move.make_repeatable_move_pair(function()
			if has_ts() then
				require("vim.treesitter._select").select_parent(vim.v.count1)
			else
				vim.lsp.buf.selection_range(vim.v.count1)
			end
		end, function()
			if has_ts() then
				require("vim.treesitter._select").select_child(vim.v.count1)
			else
				vim.lsp.buf.selection_range(vim.v.count1)
			end
		end)
		map({ "x", "o" }, "an", select_parent)
		map({ "x", "o" }, "in", select_child)
	end,
}
