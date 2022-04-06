local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

telescope.load_extension("projects")
local actions = require("telescope.actions")
-- telescope.load_extension('media_files')

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
			sort_lastused = true,
			mappings = {
				i = {
					["<c-f>"] = actions.delete_buffer,
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

-- TELESCOPE APPLY COLORSCHEME WITHOUT CLOSING THE PICKER
local M = {}

M.choose_colors = function()
	local actions_state = require("telescope.actions.state")
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local sorters = require("telescope.sorters")
	local dropdown = require("telescope.themes").get_dropdown()

	function Enter(prompt_bufnr)
		local selected = actions_state.get_selected_entry()
		local cmd = "colorscheme " .. selected[1]
		vim.cmd(cmd)

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
			map("i", "<C-j>", Enter)
			map("i", "<C-k>", Next_color)
			map("i", "<C-l>", Prev_color)
			return true
		end,
	}

	local colorsExecute = pickers.new(dropdown, opts)
	colorsExecute:find()
end

return M
