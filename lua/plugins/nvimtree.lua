local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

nvim_tree.setup({
	disable_netrw = true,
	hijack_netrw = true,
	open_on_setup = false,
	ignore_ft_on_setup = {},
	auto_close = false,
	auto_reload_on_write = true,
	open_on_tab = false,
	hijack_cursor = true,
	update_cwd = true, --IMPORTANT (true) FOR UPDATING FOLDER (big folders structure)
	hijack_unnamed_buffer_when_opening = false,
	hijack_directories = {
		enable = true,
		auto_open = true,
	},
	update_focused_file = {
		enable = true, --cursor goes to the file
		update_cwd = true, --change the folders on new project
	},
	view = {
		width = 30,
		height = 30,
		hide_root_folder = false,
		side = "left",
		auto_resize = true,
		mappings = {
			custom_only = false,
			list = {
				{ key = { "l", "<CR>", "o" }, action = "edit" },
			},
		},
		signcolumn = "yes",
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
})
