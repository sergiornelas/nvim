local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
	return
end

telescope.load_extension("frecency")
telescope.load_extension("fzf")
telescope.load_extension("harpoon")

local actions = require("telescope.actions")
telescope.setup({
	defaults = {
		layout_strategy = "flex", --toggle between horizontal/vertical
		sorting_strategy = "ascending", --important
		winblend = 12,
		results_title = "",
		layout_config = {
			horizontal = {
				width = 130,
				height = 25,
				preview_width = 60,
			},
			vertical = {
				width = 73,
				height = 37,
			},
		},
		-- previewer = false
		-- mirror = true,
		-- prompt_position = "top",
		-- preview_cutoff = 120,
		-- height = 0.60, (percentages)
		-- width = { 0.52, max = 0.52, min = 0.52 },
		-- initial_mode = "insert",
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },
		mappings = {
			i = {
				["<C-i>"] = actions.move_selection_next,
				["<C-o>"] = actions.move_selection_previous,
				["<C-j>"] = actions.select_default,
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,
				["<C-s>"] = actions.select_horizontal,
				["<C-k>"] = actions.select_tab,
				["<C-a>"] = { "<esc>", type = "command" },
				["<esc>"] = actions.close,
			},
		},
	},
	pickers = {
		colorscheme = {
			enable_preview = true, --some colorschemes break
		},
		buffers = {
			sort_lastused = true,
			mappings = {
				i = {
					["<c-f>"] = actions.delete_buffer,
				},
			},
		},
		git_status = {
			mappings = {
				i = {
					["<C-i>"] = actions.move_selection_next,
					["<C-o>"] = actions.move_selection_previous,
				},
			},
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
		frecency = {
			show_scores = true,
			ignore_patterns = { "*.git/*", "*/tmp/*" },
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
