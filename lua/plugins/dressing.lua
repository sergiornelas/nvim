local M = {
	"stevearc/dressing.nvim",
	event = "BufReadPre",
}

function M.config()
	local dressing_ok, dressing = pcall(require, "dressing")
	if not dressing_ok then
		return
	end

	dressing.setup({
		input = {
			title_pos = "center",
			border = "single",
			win_options = {
				winblend = 0,
			},
			mappings = {
				n = {
					["<esc>"] = "Close",
					["<cr>"] = "Confirm",
					["<c-j>"] = "Confirm",
				},
				i = {
					["<cr>"] = "Confirm",
					["<c-j>"] = "Confirm",
				},
			},
		},
		select = {
			backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
			telescope = nil,
			builtin = {
				border = "single",
			},
			get_config = function(opts)
				if opts.kind == "codeaction" then
					return {
						telescope = require("telescope.themes").get_cursor({
							layout_config = { height = 0.2 },
							prompt_title = "Code actions </>",
						}),
					}
				end
			end,
		},
	})
end

return M

-- Realized that native lsp features are better because it adds more content
-- on diagnostics and code_actions
