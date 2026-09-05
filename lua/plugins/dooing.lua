-- Google Drive sync for dooing — synchronize your todo list across machines.
-- https://github.com/ImmanuelHaffner/dooing-sync.nvim

return {
	"atiladefreitas/dooing",
	keys = {
		{ "<leader>d", "<cmd>Dooing<cr>" },
		{ "<leader>0", "<cmd>DooingLocal<cr>" },
	},
	config = function()
		require("dooing").setup({
			ui = {
				style = "modern", -- "classic" | "modern"
			},
			window = {
				dimensions = {
					width = 80,
					height = 37,
				},
				border = "double", -- Border style: 'single', 'double', 'rounded', 'solid'
			},
			formatting = {
				pending = {
					icon = "󰄱",
				},
				in_progress = {
					icon = "󰛲",
				},
				done = {
					icon = "󰱒",
				},
			},
			quick_keys = true,
			per_project = {
				on_missing = "auto_create", -- What to do when file missing ("prompt"/"auto_create")
			},
			keymaps = {
				open_project_todo = "<leader>0", -- Toggle project-specific todos
				show_due_notification = "<leader>tN", -- Show due items window
			},
		})
	end,
}
