local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

telescope.load_extension("projects")
telescope.load_extension("fzf")
telescope.load_extension("heading")

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },
		mappings = {
			i = {
				["<tab>"] = actions.move_selection_next,
				["<C-o>"] = actions.move_selection_previous,
				["<C-j>"] = actions.select_default,
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,
				["<C-s>"] = actions.select_horizontal,
				["<C-e>"] = actions.select_tab,
        ["<C-a>"] = { "<esc>", type = "command" },
        ["<esc>"] = actions.close,
			},
		},
	},
	pickers = {
		colorscheme = {
			enable_preview = true,
		},
		buffers = {
			sort_lastused = false,
			mappings = {
				i = {
					["<c-f>"] = actions.delete_buffer,
				},
			},
		},
		find_files = {
			theme = "ivy",
			winblend = 10,
		},
		live_grep = {
			theme = "ivy",
			winblend = 10,
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
		heading = {
			treesitter = true,
		},
	},
})

-- Token  	       Match type           	          Description
-- -------+-----------------------------+-----------------------------------
-- sbtrkt 	fuzzy-match                 	Items that match sbtrkt
-- 'wild  	exact-match (quoted)        	Items that include wild
-- ^music 	prefix-exact-match          	Items that start with music
-- .mp3$  	suffix-exact-match          	Items that end with .mp3
-- !fire  	inverse-exact-match         	Items that do not include fire
-- !^music	inverse-prefix-exact-match  	Items that do not start with music
-- !.mp3$ 	inverse-suffix-exact-match  	Items that do not end with .mp3
