return {
	"nvim-mini/mini.files",
	dependencies = {
		"nvim-mini/mini.icons",
	},
	opts = {
		mappings = {
			close = "<esc>",
			go_in = "L",
			go_in_plus = "l",
			go_out = "h",
			go_out_plus = "H",
			mark_goto = "'",
			mark_set = "m",
			reset = "<c-h>",
			reveal_cwd = "<c-k>",
			show_help = "g?",
			synchronize = "<c-j>",
			trim_left = "<",
			trim_right = ">",
		},
		windows = {
			preview = true,
		},
	},
	keys = {
		{
			"<leader>o",
			function()
				require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
			end,
			desc = "Open mini.files (Directory of Current File)",
		},
		{
			"<leader>O",
			function()
				require("mini.files").open(vim.uv.cwd(), true)
			end,
			desc = "Open mini.files (cwd)",
		},
	},
	config = function(_, opts)
		require("mini.files").setup(opts)

		local show_dotfiles = true
		local filter_show = function(fs_entry)
			return true
		end
		local filter_hide = function(fs_entry)
			return not vim.startswith(fs_entry.name, ".")
		end

		local toggle_dotfiles = function()
			show_dotfiles = not show_dotfiles
			local new_filter = show_dotfiles and filter_show or filter_hide
			require("mini.files").refresh({ content = { filter = new_filter } })
		end

		local map_split = function(buf_id, lhs, direction)
			local rhs = function()
				local new_target_window
				local cur_target_window = require("mini.files").get_explorer_state().target_window
				if cur_target_window ~= nil then
					vim.api.nvim_win_call(cur_target_window, function()
						vim.cmd("belowright " .. direction .. " split")
						new_target_window = vim.api.nvim_get_current_win()
					end)
					require("mini.files").set_target_window(new_target_window)
					require("mini.files").go_in({ close_on_file = true })
				end
			end
			vim.keymap.set("n", lhs, rhs, { buffer = buf_id })
		end

		local files_set_cwd = function()
			local cur_entry_path = MiniFiles.get_fs_entry().path
			local cur_directory = vim.fs.dirname(cur_entry_path)
			if cur_directory ~= nil then
				vim.fn.chdir(cur_directory)
			end
		end

		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesBufferCreate",
			callback = function(args)
				local buf_id = args.data.buf_id

				vim.keymap.set(
					"n",
					opts.mappings and opts.mappings.toggle_hidden or "g.",
					toggle_dotfiles,
					{ buffer = buf_id }
				)

				vim.keymap.set(
					"n",
					opts.mappings and opts.mappings.change_cwd or "gc",
					files_set_cwd,
					{ buffer = args.data.buf_id, desc = "Set cwd" }
				)

				map_split(buf_id, opts.mappings and opts.mappings.go_in_horizontal_plus or "<c-w>s", "horizontal")
				map_split(buf_id, opts.mappings and opts.mappings.go_in_vertical_plus or "<c-w>v", "vertical")
				map_split(buf_id, opts.mappings and opts.mappings.go_in_horizontal_plus or "<c-w><c-s>", "horizontal")
				map_split(buf_id, opts.mappings and opts.mappings.go_in_vertical_plus or "<c-w><c-v>", "vertical")
			end,
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesActionRename",
			callback = function(event)
				Snacks.rename.on_rename_file(event.data.from, event.data.to)
			end,
		})
		-- =============================================================================
		-- Window width based on the offset from the center, i.e. center window
		-- is 60, then next over is 20, then the rest are 10.
		-- Can use more resolution if you want like { 60, 20, 20, 10, 5 }
		local widths = { 40, 20, 20, 10, 5 }

		local ensure_center_layout = function(ev)
			local state = MiniFiles.get_explorer_state()
			if state == nil then
				return
			end

			-- Compute "depth offset" - how many windows are between this and focused
			local path_this = vim.api.nvim_buf_get_name(ev.data.buf_id):match("^minifiles://%d+/(.*)$")
			local depth_this
			for i, path in ipairs(state.branch) do
				if path == path_this then
					depth_this = i
				end
			end
			if depth_this == nil then
				return
			end
			local depth_offset = depth_this - state.depth_focus

			-- Adjust config of this event's window
			local i = math.abs(depth_offset) + 1
			local win_config = vim.api.nvim_win_get_config(ev.data.win_id)
			win_config.width = i <= #widths and widths[i] or widths[#widths]

			win_config.col = math.floor(0.5 * (vim.o.columns - widths[1]))
			for j = 1, math.abs(depth_offset) do
				local sign = depth_offset == 0 and 0 or (depth_offset > 0 and 1 or -1)
				-- widths[j+1] for the negative case because we don't want to add the center window's width
				local prev_win_width = (sign == -1 and widths[j + 1]) or widths[j] or widths[#widths]
				-- Add an extra +2 each step to account for the border width
				win_config.col = win_config.col + sign * (prev_win_width + 2)
			end

			win_config.height = depth_offset == 0 and 30 or 20
			win_config.row = math.floor(0.5 * (vim.o.lines - win_config.height))
			win_config.border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }
			vim.api.nvim_win_set_config(ev.data.win_id, win_config)
		end

		vim.api.nvim_create_autocmd("User", { pattern = "MiniFilesWindowUpdate", callback = ensure_center_layout })
		-- =============================================================================

		-- macOS Quick Look with mini.files
		local qpreview = function()
			local path = (MiniFiles.get_fs_entry() or {}).path
			if path == nil then
				return vim.notify("Cursor is not on valid entry")
			end
			vim.system({ "qlmanage", "-p", path }, {}, function(result)
				if result.code ~= 0 then
					vim.notify("'qlmanage -p' failed with code: " .. result.code)
					vim.notify("Stderr:\n" .. result.stderr)
				end
			end)
		end
		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesBufferCreate",
			callback = function(args)
				local b = args.data.buf_id
				vim.keymap.set("n", "g<leader>", qpreview, { buffer = b, desc = "Quick Preview" })
			end,
		})
	end,
}
