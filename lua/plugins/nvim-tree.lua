local M = {
	"kyazdani42/nvim-tree.lua",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
	keys = {
		{ "<leader>j", "<cmd>NvimTreeToggle<cr>" },
	},
	lazy = false,
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
		local mappings = {
			-- BEGIN_DEFAULT_ON_ATTACH
			["<c-]>"] = { api.tree.change_root_to_node, "CD" },
			-- ["<C-e>"] = { api.node.open.replace_tree_buffer, "Open: In Place" },
			["<c-k>"] = { api.node.show_info_popup, "Info" },
			["<c-r>"] = { api.fs.rename_sub, "Rename: Omit Filename" },
			["<c-t>"] = { api.node.open.tab, "Open: New Tab" },
			["<c-v>"] = { api.node.open.vertical, "Open: Vertical Split" },
			["<C-x>"] = { api.node.open.horizontal, "Open: Horizontal Split" },
			["<bs>"] = { api.node.navigate.parent_close, "Close Directory" },
			["<cr>"] = { api.node.open.edit, "Open" },
			["<tab>"] = { api.node.open.preview, "Open Preview" },
			[">"] = { api.node.navigate.sibling.next, "Next Sibling" },
			["<"] = { api.node.navigate.sibling.prev, "Previous Sibling" },
			["."] = { api.node.run.cmd, "Run Command" },
			["-"] = { api.tree.change_root_to_parent, "Up" },
			["a"] = { api.fs.create, "Create" },
			["bmv"] = { api.marks.bulk.move, "Move Bookmarked" },
			["B"] = { api.tree.toggle_no_buffer_filter, "Toggle No Buffer" },
			["c"] = { api.fs.copy.node, "Copy" },
			["C"] = { api.tree.toggle_git_clean_filter, "Toggle Git Clean" },
			["[c"] = { api.node.navigate.git.prev, "Prev Git" },
			["]c"] = { api.node.navigate.git.next, "Next Git" },
			["d"] = { api.fs.remove, "Delete" },
			["D"] = { api.fs.trash, "Trash" },
			["E"] = { api.tree.expand_all, "Expand All" },
			["e"] = { api.fs.rename_basename, "Rename: Basename" },
			["]e"] = { api.node.navigate.diagnostics.next, "Next Diagnostic" },
			["[e"] = { api.node.navigate.diagnostics.prev, "Prev Diagnostic" },
			["F"] = { api.live_filter.clear, "Clean Filter" },
			["f"] = { api.live_filter.start, "Filter" },
			["g?"] = { api.tree.toggle_help, "Help" },
			["gy"] = { api.fs.copy.absolute_path, "Copy Absolute Path" },
			["H"] = { api.tree.toggle_hidden_filter, "Toggle Dotfiles" },
			["I"] = { api.tree.toggle_gitignore_filter, "Toggle Git Ignore" },
			["J"] = { api.node.navigate.sibling.last, "Last Sibling" },
			["K"] = { api.node.navigate.sibling.first, "First Sibling" },
			["m"] = { api.marks.toggle, "Toggle Bookmark" },
			["o"] = { api.node.open.edit, "Open" },
			["O"] = { api.node.open.no_window_picker, "Open: No Window Picker" },
			["p"] = { api.fs.paste, "Paste" },
			["P"] = { api.node.navigate.parent, "Parent Directory" },
			["q"] = { api.tree.close, "Close" },
			["<esc>"] = { api.tree.close, "Close" },
			["r"] = { api.fs.rename, "Rename" },
			["R"] = { api.tree.reload, "Refresh" },
			["s"] = { api.node.run.system, "Run System" },
			["S"] = { api.tree.search_node, "Search" },
			["U"] = { api.tree.toggle_custom_filter, "Toggle Hidden" },
			["W"] = { api.tree.collapse_all, "Collapse" },
			["x"] = { api.fs.cut, "Cut" },
			["y"] = { api.fs.copy.filename, "Copy Name" },
			["Y"] = { api.fs.copy.relative_path, "Copy Relative Path" },
			["<2-LeftMouse>"] = { api.node.open.edit, "Open" },
			["<2-RightMouse>"] = { api.tree.change_root_to_node, "CD" },
			-- END_DEFAULT_ON_ATTACH

			-- Mappings migrated from view.mappings.list
			["l"] = { api.node.open.edit, "Open" },
			-- ["<CR>"] = { api.node.open.edit, "Open" },
			-- ["o"] = { api.node.open.edit, "Open" },
			["h"] = { api.node.navigate.parent_close, "Close Directory" },
			["v"] = { api.node.open.vertical, "Open: Vertical Split" },
			["N"] = { api.tree.change_root_to_node, "CD" },
		}

		for keys, mapping in pairs(mappings) do
			vim.keymap.set("n", keys, mapping[1], opts(mapping[2]))
		end
	end

	nvim_tree.setup({
		on_attach = my_on_attach,
		disable_netrw = true,
		hijack_cursor = true,
		update_focused_file = {
			enable = true, --cursor goes to the file
			update_root = { -- Update the root directory of the tree if the file is not under current root directory.
				enable = true,
			},
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
			preserve_window_proportions = true,
			centralize_selection = true, --  auto zz
			adaptive_size = true,
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
