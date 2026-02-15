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
		},
		{
			"<leader>O",
			function()
				require("mini.files").open(vim.uv.cwd(), true)
			end,
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
