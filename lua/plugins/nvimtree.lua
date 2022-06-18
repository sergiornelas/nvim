local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

nvim_tree.setup({
	disable_netrw = true,
	hijack_netrw = true,
	ignore_ft_on_setup = {},
	open_on_tab = false,
	hijack_cursor = true,
	update_cwd = true, --IMPORTANT (true) FOR UPDATING FOLDER (big folders structure)
	respect_buf_cwd = true,
	hijack_directories = {
		enable = true,
		auto_open = true,
	},
	update_focused_file = {
		enable = true, --cursor goes to the file
		update_cwd = true, --change the folders on new project
	},
	view = {
		hide_root_folder = false,
		side = "left",
		mappings = {
			custom_only = true,
			list = {
				{ key = { "l", "<CR>", "o" }, action = "edit" },
				{ key = "q", action = "copy_path" },
				{ key = "gk", action = "prev_git_item" },
				{ key = "gj", action = "next_git_item" },
				{ key = "<C-e>", action = "edit_in_place" },
				{ key = "O", action = "edit_no_picker" },
				{ key = { "<C-]>", "<2-RightMouse>" }, action = "cd" },
				{ key = "<C-v>", action = "vsplit" },
				{ key = "<C-x>", action = "split" },
				{ key = "<C-z>", action = "tabnew" },
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
				{ key = "<C-r>", action = "full_rename" },
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
				-- { key = "<C-k>", action = "toggle_file_info" }
			},
		},
		signcolumn = "yes",
		adaptive_size = true,
	},
	actions = {
		change_dir = {
			global = false,
		},
		open_file = {
			quit_on_open = false,
		},
	},
	git = {
		ignore = false,
	},
	renderer = {
		icons = {
			glyphs = {
				git = {
					unstaged = "",
				},
			},
		},
	},
	-- auto_close = false,
})
