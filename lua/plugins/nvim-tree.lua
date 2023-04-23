local M = {
	"kyazdani42/nvim-tree.lua",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
	lazy = false,
	-- lazy loading not working:
	-- keys = {
	-- 	{ "<leader>w", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree" },
	-- },
	-- cmd = "NvimTreeToggle",
}

function M.config()
	local nvim_tree_ok, nvim_tree = pcall(require, "nvim-tree")
	if not nvim_tree_ok then
		return
	end

	local function my_on_attach(bufnr)
		local api = require("nvim-tree.api")
		local function opts(desc)
			return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end
		local keymap = vim.keymap.set
		keymap("n", "<c-n>", api.tree.change_root_to_node, opts("CD"))
		keymap("n", "<c-p>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
		keymap("n", "<c-k>", api.node.show_info_popup, opts("Info"))
		keymap("n", "<cr>", api.fs.rename_sub, opts("Rename: Omit Filename"))
		keymap("n", "<c-t>", api.node.open.tab, opts("Open: New Tab"))
		keymap("n", "<c-v>", api.node.open.vertical, opts("Open: Vertical Split"))
		keymap("n", "<c-s>", api.node.open.horizontal, opts("Open: Horizontal Split"))
		keymap("n", "<c-h>", api.node.navigate.parent_close, opts("Close Directory"))
		keymap("n", "l", api.node.open.edit, opts("Open"))
		keymap("n", "<c-i>", api.node.open.preview, opts("Open Preview"))
		keymap("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
		keymap("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
		keymap("n", ".", api.node.run.cmd, opts("Run Command"))
		keymap("n", "-", api.tree.change_root_to_parent, opts("Up"))
		keymap("n", "a", api.fs.create, opts("Create"))
		keymap("n", "mv", api.marks.bulk.move, opts("Move Bookmarked"))
		keymap("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle No Buffer"))
		keymap("n", "c", api.fs.copy.node, opts("Copy"))
		keymap("n", "G", api.tree.toggle_git_clean_filter, opts("Toggle Git Clean"))
		keymap("n", "go", api.node.navigate.git.prev, opts("Prev Git"))
		keymap("n", "gi", api.node.navigate.git.next, opts("Next Git"))
		keymap("n", "d", api.fs.remove, opts("Delete"))
		keymap("n", "D", api.fs.trash, opts("Trash"))
		keymap("n", "E", api.tree.expand_all, opts("Expand All"))
		keymap("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
		keymap("n", "gn", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
		keymap("n", "gp", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
		keymap("n", "F", api.live_filter.clear, opts("Clean Filter"))
		keymap("n", "f", api.live_filter.start, opts("Filter"))
		keymap("n", "g?", api.tree.toggle_help, opts("Help"))
		keymap("n", "gq", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
		keymap("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
		keymap("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
		keymap("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
		keymap("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
		keymap("n", "mm", api.marks.toggle, opts("Toggle Bookmark"))
		keymap("n", "o", api.node.open.no_window_picker, opts("Open: No Window Picker"))
		keymap("n", "p", api.fs.paste, opts("Paste"))
		keymap("n", "P", api.node.navigate.parent, opts("Parent Directory"))
		keymap("n", "<esc>", api.tree.close, opts("Close"))
		keymap("n", "r", api.fs.rename, opts("Rename"))
		keymap("n", "R", api.tree.reload, opts("Refresh"))
		keymap("n", "s", api.node.run.system, opts("Run System"))
		keymap("n", "S", api.tree.search_node, opts("Search"))
		keymap("n", "U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
		keymap("n", "W", api.tree.collapse_all, opts("Collapse"))
		keymap("n", "x", api.fs.cut, opts("Cut"))
		keymap("n", "q", api.fs.copy.filename, opts("Copy Name"))
		keymap("n", "Q", api.fs.copy.relative_path, opts("Copy Relative Path"))
	end

	nvim_tree.setup({
		on_attach = my_on_attach,
		disable_netrw = true,
		hijack_cursor = true,
		update_focused_file = {
			enable = true, --cursor goes to the file
			update_root = true, --Update the root directory of the tree if the file is not under current root directory.
			-- disabled because updates to current folder instead root .git
		},
		diagnostics = {
			enable = true,
		},
		-- root_dirs = { ".git" }, -- Preferred root directories. Only relevant when `update_focused_file.update_root` is `true`
		prefer_startup_root = false, --Prefer startup root directory when updating root directory of the tree. Only relevant when `update_focused_file.update_root` is `true`
		sync_root_with_cwd = false, --Changes the tree root directory on `DirChanged` and refreshes the tree.
		reload_on_bufenter = false, --Automatically reloads the tree on `BufEnter` nvim-tree.
		respect_buf_cwd = true, --Will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
		renderer = {
			highlight_opened_files = "icon",
			icons = {
				glyphs = {
					git = {
						unstaged = "🐻",
					},
					folder = {
						arrow_closed = "",
						arrow_open = "",
					},
				},
			},
			indent_markers = {
				enable = false,
			},
		},
		actions = {
			open_file = {
				quit_on_open = true,
			},
		},
		view = {
			adaptive_size = true,
			centralize_selection = true,
			hide_root_folder = false,
			side = "left",
			signcolumn = "yes",
			float = {
				enable = false,
				open_win_config = {
					relative = "cursor",
					border = "shadow",
					height = 33,
					col = 4,
				},
			},
		},
	})
end

return M
