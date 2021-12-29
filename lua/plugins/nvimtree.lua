-- local present, nvimtree = pcall(require, "nvim-tree")
--
-- if not present then
--    return
-- end
--
-- local tree_cb = require'nvim-tree.config'.nvim_tree_callback
-- vim.g.nvim_tree_respect_buf_cwd = 1 --update when switch project
--
-- vim.o.termguicolors = true
--
-- vim.g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
-- vim.g.nvim_tree_highlight_opened_files = 0
-- vim.g.nvim_tree_indent_markers = 1
-- vim.g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }
-- vim.g.nvim_tree_quit_on_open = 0 -- closes tree when file's opened
-- vim.g.nvim_tree_root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" }
-- --
-- vim.g.nvim_tree_show_icons = {
--    folders = 1,
--    files = 1,
-- }
--
-- vim.g.nvim_tree_icons = {
--    default = "",
--    symlink = "",
--    git = {
--       deleted = "",
--       ignored = "◌",
--       renamed = "➜",
--       staged = "✓",
--       unmered = "",
--       unstaged = "✗",
--       untracked = "★",
--    },
--    folder = {
--       arrow_open = "",
--       arrow_closed = "",
--       default = "",
--       empty = "",
--       empty_open = "",
--       open = "",
--       symlink = "",
--       symlink_open = "",
--    },
-- }
--
-- nvimtree.setup {
--    filters = {
--       dotfiles = false,
--    },
--    disable_netrw = true,
--    hijack_netrw = true,
--    ignore_ft_on_setup = { "dashboard" },
--    auto_close = false,
--    open_on_tab = false,
--    hijack_cursor = true,
--    update_cwd = true,
--    update_focused_file = {
--       enable = true,
--       update_cwd = true,
--    },
--    view = {
--       allow_resize = true,
--       side = "left",
--       width = 30,
--       mappings ={
--       list = {
--        { key = {"l", "<CR>", "<2-LeftMouse>"}, cb = tree_cb("edit") },
--       }
--       }
--    },
-- }

local present, _ = pcall(require, "nvim-tree")
-- vim.cmd [[highlight NvimTreeNormal guifg=#D8DEE9  guibg=#2a2e39]]
if not present then
   return
end

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
-- vim.g.nvim_tree_root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" }
-- vim.g.nvim_tree_respect_buf_cwd = 1 --update when switch project

require("nvim-tree").setup({
  hijack_cursor = true,
  update_cwd = true,        --update when switch project
  update_focused_file = {   --update when switch project
    enable = true,
    update_cwd = true
  },
  view ={
    mappings ={
      list ={
       { key = {"l", "<CR>", "<2-LeftMouse>"}, cb = tree_cb("edit") },
      }
    }
  },
})
