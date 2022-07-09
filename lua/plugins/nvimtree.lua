local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

nvim_tree.setup({
	disable_netrw = true,
	hijack_cursor = true,
	update_focused_file = {
		enable = true, --cursor goes to the file
		update_root = false, --Update the root directory of the tree if the file is not under current root directory.
		-- disabled because updates to current folder instead root .git
	},
	-- root_dirs = { ".git" }, -- Preferred root directories. Only relevant when `update_focused_file.update_root` is `true`
	prefer_startup_root = false, --Prefer startup root directory when updating root directory of the tree. Only relevant when `update_focused_file.update_root` is `true`
	sync_root_with_cwd = true, --Changes the tree root directory on `DirChanged` and refreshes the tree.
	reload_on_bufenter = false, --Automatically reloads the tree on `BufEnter` nvim-tree.
	respect_buf_cwd = true, --Will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
	renderer = {
		highlight_opened_files = "icon",
		icons = {
			glyphs = {
				git = {
					unstaged = "",
				},
			},
		},
		indent_markers = {
			enable = false,
		},
	},
	view = {
		hide_root_folder = false,
		side = "left",
		signcolumn = "yes",
		adaptive_size = true,
		mappings = {
			custom_only = true,
			list = {
				{ key = { "l", "<CR>", "o" }, action = "edit" },
				{ key = "q", action = "copy_path" },
				{ key = "gk", action = "prev_git_item" },
				{ key = "gj", action = "next_git_item" },
				{ key = "O", action = "edit_no_picker" },
				{ key = { "<C-]>", "<2-RightMouse>" }, action = "cd" },
				{ key = "<C-s>", action = "split" },
        { key = "<C-v>", action = "vsplit" },
				{ key = "<C-o>", action = "tabnew" },
				{ key = "<", action = "prev_sibling" },
				{ key = ">", action = "next_sibling" },
				{ key = "P", action = "parent_node" },
				{ key = "<BS>", action = "close_node" },
				{ key = "<Tab>", action = "preview" },
				{ key = "K", action = "first_sibling" },
				{ key = "J", action = "last_sibling" },
				{ key = "I", action = "toggle_git_ignored" },
				{ key = "H", action = "toggle_dotfiles" },
				{ key = "U", action = "toggle_custom" },
				{ key = "R", action = "refresh" },
				{ key = "a", action = "create" },
				{ key = "d", action = "remove" },
				{ key = "D", action = "trash" },
				{ key = "r", action = "rename" },
				{ key = "x", action = "cut" },
				{ key = "c", action = "copy" },
				{ key = "p", action = "paste" },
				{ key = "y", action = "copy_name" },
				{ key = "gy", action = "copy_absolute_path" },
				{ key = "-", action = "dir_up" },
				{ key = "s", action = "system_open" },
				{ key = "f", action = "live_filter" },
				{ key = "F", action = "clear_live_filter" },
				{ key = "W", action = "collapse_all" },
				{ key = "E", action = "expand_all" },
				{ key = "S", action = "search_node" },
				{ key = ".", action = "run_file_command" },
				{ key = "g?", action = "toggle_help" },
				-- { key = "<C-a>", action = "full_rename" },
				-- { key = "<C-e>", action = "edit_in_place" },
				-- { key = "<C-k>", action = "toggle_file_info" }
			},
		},
	},
})
