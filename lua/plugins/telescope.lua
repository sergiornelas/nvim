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
				["<esc>"] = actions.close,
				["<C-k>"] = actions.move_selection_next,
				["<C-l>"] = actions.move_selection_previous,
				["<C-j>"] = actions.select_default,
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,
			},
		},
	},
	pickers = {
		find_files = {
			theme = "ivy",
		},
		live_grep = {
			theme = "ivy",
		},
		buffers = {
			sort_lastused = false,
			mappings = {
				i = {
					["<c-f>"] = actions.delete_buffer,
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
    heading = {
      treesitter = true,
    },
	},
})

-- TELESCOPE APPLY COLORSCHEME WITHOUT CLOSING THE PICKER
-- AND PERSIST COLOR TO THE NEXT SESSION
local M = {}
M.choose_colors = function()
	local actions_state = require("telescope.actions.state")
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local sorters = require("telescope.sorters")
	local dropdown = require("telescope.themes").get_dropdown()
	-- local dropdown = require("telescope.themes").get_dropdown({ winblend = 20 })

	function SelectPersistColor(prompt_bufnr)
		local selected = actions_state.get_selected_entry()
		local cmd = "colorscheme " .. selected[1]
		vim.cmd(cmd) --executes new color when c-j. Useful for selecting when filtering

		-- selected colorscheme persists when you close neovim (sed mac os)
		local job_cmd = "sed -i '' 's/.*colorscheme.*/" .. cmd .. "/' ~/.config/nvim/lua/colorscheme.lua"
		vim.fn.jobstart(job_cmd)

		actions.close(prompt_bufnr)
	end

	function Next_color(prompt_bufnr)
		actions.move_selection_next(prompt_bufnr)
		local selected = actions_state.get_selected_entry()
		local cmd = "colorscheme " .. selected[1]
		vim.cmd(cmd)
	end

	function Prev_color(prompt_bufnr)
		actions.move_selection_previous(prompt_bufnr)
		local selected = actions_state.get_selected_entry()
		local cmd = "colorscheme " .. selected[1]
		vim.cmd(cmd)
	end

	local colors = vim.fn.getcompletion("", "color")
	local opts = {
		finder = finders.new_table(colors),
		sorter = sorters.get_generic_fuzzy_sorter({}),
		attach_mappings = function(prompt_bufnr, map)
			map("i", "<C-j>", SelectPersistColor)
			map("i", "<cr>", SelectPersistColor)
			map("i", "<C-k>", Next_color)
			map("i", "<C-l>", Prev_color)
			return true
		end,
	}

	local colorsExecute = pickers.new(dropdown, opts)
	colorsExecute:find()
end

return M

-- Token  	       Match type           	          Description
-- -------+-----------------------------+-----------------------------------
-- sbtrkt 	fuzzy-match                 	Items that match sbtrkt
-- 'wild  	exact-match (quoted)        	Items that include wild
-- ^music 	prefix-exact-match          	Items that start with music
-- .mp3$  	suffix-exact-match          	Items that end with .mp3
-- !fire  	inverse-exact-match         	Items that do not include fire
-- !^music	inverse-prefix-exact-match  	Items that do not start with music
-- !.mp3$ 	inverse-suffix-exact-match  	Items that do not end with .mp3
