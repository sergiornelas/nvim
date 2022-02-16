local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

telescope.load_extension("projects")
-- telescope.load_extension('media_files')
local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_next,
				["<C-l>"] = actions.move_selection_previous,
				["<C-j>"] = actions.select_default,
			},
		},
	},
	pickers = {
		find_files = {
			theme = "ivy",
		},
		buffers = {
			sort_lastused = true,
			mappings = {
				i = {
					["<c-g>"] = actions.delete_buffer,
				},
			},
		},
	},
	-- extensions = {
	--   media_files = {
	--     -- filetypes whitelist
	--     -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
	--     filetypes = {"png", "webp", "jpg", "jpeg"},
	--     find_cmd = "rg" -- find command (defaults to `fd`)
	--   }
	-- },
})
