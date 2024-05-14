return {
	"backdround/global-note.nvim",
	keys = { "<leader>n", "<leader>p" },
	config = function()
		local global_note = require("global-note")

		local get_project_name = function()
			---@diagnostic disable-next-line: undefined-field
			local project_directory, err = vim.loop.cwd()
			if project_directory == nil then
				vim.notify(err, vim.log.levels.WARN)
				return nil
			end
			local project_name = vim.fs.basename(project_directory)
			if project_name == nil then
				vim.notify("Unable to get the project name", vim.log.levels.WARN)
				return nil
			end
			return project_name
		end

		global_note.setup({
			filename = "main.md",
			directory = "~/notes/scratch/",
			title = "~Notes~",
			command_name = "GlobalNote",
			window_config = function()
				local window_height = vim.api.nvim_list_uis()[1].height
				local window_width = vim.api.nvim_list_uis()[1].width
				return {
					relative = "editor",
					border = "single",
					title = "Note",
					title_pos = "center",
					width = math.floor(0.7 * window_width),
					height = math.floor(0.85 * window_height),
					row = math.floor(0.05 * window_height),
					col = math.floor(0.15 * window_width),
				}
			end,
			-- It's called after the window creation.
			-- fun(buffer_id: number, window_id: number)
			post_open = function(_, _) end,
			autosave = true,
			additional_presets = {
				project_local = {
					command_name = "ProjectNote",
					filename = function()
						return get_project_name() .. ".md"
					end,
					title = "Project note",
				},
			},
		})

		vim.keymap.set("n", "<leader>n", global_note.toggle_note)
		vim.keymap.set("n", "<leader>p", function()
			global_note.toggle_note("project_local")
		end)
	end,
}
