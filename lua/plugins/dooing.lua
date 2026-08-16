-- Google Drive sync for dooing — synchronize your todo list across machines.
-- https://github.com/ImmanuelHaffner/dooing-sync.nvim

return {
	"atiladefreitas/dooing",
	keys = {
		{ "<leader>do", "<cmd>Dooing<cr>" },
	},
	config = function()
		require("dooing").setup({
			ui = {
				-- style = "modern", -- "classic" | "modern"
			},
			window = {
				border = "single", -- Border style: 'single', 'double', 'rounded', 'solid'
			},
			quick_keys = true,
			per_project = {
				on_missing = "auto_create", -- What to do when file missing ("prompt"/"auto_create")
			},
			keymaps = {
				open_project_todo = "<leader>d0", -- Toggle project-specific todos
				show_due_notification = "<leader>tN", -- Show due items window
			},
		})
	end,
}
