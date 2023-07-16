local M = {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	build = "make",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
}

function M.config()
	local telescope_ok, telescope = pcall(require, "telescope")
	if not telescope_ok then
		return
	end

	local actions = require("telescope.actions")
	telescope.setup({
		defaults = {
			layout_strategy = "vertical", --horizontal/vertical/flex
			sorting_strategy = "ascending", --important
			winblend = 12,
			results_title = "",
			layout_config = {
				vertical = {
					width = 87,
					height = 53,
				},
			},
			-- previewer = false
			-- mirror = true,
			-- prompt_position = "top",
			-- preview_cutoff = 120,
			-- height = 0.60, (percentages)
			-- width = { 0.52, max = 0.52, min = 0.52 },
			-- initial_mode = "insert",
			prompt_prefix = "  ",
			selection_caret = "  ",
			path_display = { "smart" },
			mappings = {
				i = {
					["<c-i>"] = actions.move_selection_next,
					["<c-o>"] = actions.move_selection_previous,
					["<c-j>"] = actions.select_default,
					["<c-n>"] = actions.cycle_history_next,
					["<c-p>"] = actions.cycle_history_prev,
					["<c-s>"] = actions.select_horizontal,
					["<c-u>"] = actions.select_tab,
					["<c-a>"] = { "<esc>", type = "command" },
					["<c-f>"] = actions.to_fuzzy_refine,
					["<esc>"] = actions.close,
				},
			},
		},
		pickers = {
			colorscheme = {
				enable_preview = true,
			},
			buffers = {
				sort_lastused = true,
				mappings = {
					i = {
						["<c-e>"] = actions.delete_buffer,
					},
				},
			},
			git_status = {
				mappings = {
					i = {
						["<c-i>"] = actions.move_selection_next,
						["<c-o>"] = actions.move_selection_previous,
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
		},
	})

	telescope.load_extension("fzf")

	-- Token  	       Match type           	          Description
	-- -------+-----------------------------+-----------------------------------
	-- sbtrkt 	fuzzy-match                 	Items that match sbtrkt
	-- 'wild  	exact-match (quoted)        	Items that include wild
	-- ^music 	prefix-exact-match          	Items that start with music
	-- .mp3$  	suffix-exact-match          	Items that end with .mp3
	-- !fire  	inverse-exact-match         	Items that do not include fire
	-- !^music	inverse-prefix-exact-match  	Items that do not start with music
	-- !.mp3$ 	inverse-suffix-exact-match  	Items that do not end with .mp3
end

return M
