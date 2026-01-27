local map = vim.keymap.set
local opts = { noremap = true, silent = true }

return {
	{
		"OXY2DEV/markview.nvim",
		ft = "markdown",
		config = function()
			require("markview").setup({
				preview = {
					-- modes = { "n", "no", "c" },
					-- hybrid_modes = { "n" },
					-- debounce = 0,
				},
				markdown = {
					code_blocks = {
						-- set nowrap to work
						min_width = 80,
						sign = false,
					},
					headings = {
						heading_1 = {
							style = "label",
						},
						heading_2 = {
							style = "label",
						},
						heading_3 = {
							style = "label",
							sign = "󰌖 ",
						},
						heading_4 = {
							style = "label",
							sign = "󰌖 ",
						},
						heading_5 = {
							style = "label",
							sign = "󰌖 ",
						},
						heading_6 = {
							style = "label",
							sign = "󰌖 ",
						},
					},
					horizontal_rules = {
						parts = {
							{
								type = "repeating",
								repeat_amount = function(buffer)
									local utils = require("markview.utils")
									local window = utils.buf_getwin(buffer)
									local width = 80
									local textoff = vim.fn.getwininfo(window)[1].textoff
									return math.floor((width - textoff - 3) / 2)
								end,
								text = "─",
								hl = {
									"MarkviewGradient1",
									"MarkviewGradient1",
									"MarkviewGradient2",
									"MarkviewGradient2",
									"MarkviewGradient3",
									"MarkviewGradient3",
									"MarkviewGradient4",
									"MarkviewGradient4",
									"MarkviewGradient5",
									"MarkviewGradient5",
									"MarkviewGradient6",
									"MarkviewGradient6",
									"MarkviewGradient7",
									"MarkviewGradient7",
									"MarkviewGradient8",
									"MarkviewGradient8",
									"MarkviewGradient9",
									"MarkviewGradient9",
								},
							},
							{
								type = "text",
								text = "  ",
								hl = "MarkviewIcon3Fg",
							},
							{
								type = "repeating",
								repeat_amount = function(buffer)
									local utils = require("markview.utils")
									local window = utils.buf_getwin(buffer)
									local width = 80
									local textoff = vim.fn.getwininfo(window)[1].textoff
									return math.ceil((width - textoff - 3) / 2)
								end,
								direction = "right",
								text = "─",
								hl = {
									"MarkviewGradient1",
									"MarkviewGradient1",
									"MarkviewGradient2",
									"MarkviewGradient2",
									"MarkviewGradient3",
									"MarkviewGradient3",
									"MarkviewGradient4",
									"MarkviewGradient4",
									"MarkviewGradient5",
									"MarkviewGradient5",
									"MarkviewGradient6",
									"MarkviewGradient6",
									"MarkviewGradient7",
									"MarkviewGradient7",
									"MarkviewGradient8",
									"MarkviewGradient8",
									"MarkviewGradient9",
									"MarkviewGradient9",
								},
							},
						},
					},
					list_items = {
						indent_size = 1,
						shift_width = 2,
						marker_minus = {
							text = "󰧞",
						},
					},
				},
				markdown_inline = {
					checkboxes = {
						["?"] = { text = "" },
						["!"] = { text = "" },
					},
				},
			})
			require("markview.extras.checkboxes").setup({
				-- remove_style = "list_item", -- Removes the list item markers too.
				states = {
					{ " ", "X", "/", "l", "?", "!", "-" },
					{ "*", "b", "i" },
				},
			})
			require("markview.extras.headings").setup()
			require("markview.extras.editor").setup({
				max_height = 12,
				create = {
					["markdown"] = {
						init = function(buffer)
							local win = require("markview.utils").buf_getwin(buffer)
							local row = vim.api.nvim_win_get_cursor(win)[1]
							return { "```typescript", "```" }, "typescript", { row - 1, 0, row, 0 }
						end,
						language = function(input)
							if input:match("^```%s*%{(%a+)(.*)%}") then
								return input:match("^```%s*%{(%a+)(.*)%}")
							elseif input:match("^```(%a+)") then
								return input:match("^```(%a+)")
							else
								return "typescript"
							end
						end,
					},
				},
			})
			map({ "n", "x" }, "<c-c>", "<cmd>Checkbox toggle<cr>", opts) -- (vim :interrupt current (search) command)
			map("n", "<leader>I", "<cmd>Checkbox interactive<cr>", opts)
			map("n", "<leader>H", "<cmd>Heading decrease<cr>", opts)
			map("n", "<leader>L", "<cmd>Heading increase<cr>", opts)

			-- Code blocks
			map("n", "<leader>CJ", "o```javascript```<esc>Tti<cr><c-o>O", opts)
			map("n", "<leader>CT", "o```typescript```<esc>Tti<cr><c-o>O", opts)
			map("n", "<leader>CL", "o```lua```<esc>Tai<cr><c-o>O", opts)
		end,
	},
	{
		-- to work with this:
		-- cd ~/.local/share/nvim/lazy/markdown-preview.nvim
		-- npm install
		-- lua alterative:
		-- brianhuster/live-preview.nvim
		"iamcco/markdown-preview.nvim",
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		config = function()
			vim.g.mkdp_auto_close = 0
			vim.g.mkdp_page_title = "<${name}/>"
			vim.cmd([[
        let g:mkdp_preview_options = {
        \ 'disable_sync_scroll': 1,
        \ }
      ]])
			map("n", "<leader>m", "<cmd>MarkdownPreview<cr>", opts)
		end,
	},
	{
		"sergiornelas/cloak.nvim",
		ft = "markdown",
		config = function()
			require("cloak").setup({
				cloak_length = 9,
				-- Whether it should try every pattern to find the best fit or stop after the first.
				try_all_patterns = true,
				patterns = {
					{
						-- Match any file starting with '.env'.
						-- This can be a table to match multiple file patterns.
						file_pattern = "*.md",
						-- Match an equals sign and any character after it.
						-- This can also be a table of patterns to cloak,
						-- example: cloak_pattern = { ':.+', '-.+' } for yaml files.
						cloak_pattern = "::.+",
						-- A function, table or string to generate the replacement.
						replace = nil,
					},
				},
			})
		end,
	},
	{
		"okuuva/auto-save.nvim",
		version = "^1.0.0",
		cmd = "ASToggle",
		event = { "InsertLeave" },
		opts = {
			condition = function()
				if vim.bo.filetype == "markdown" then
					return true
				end
			end,
			debounce_delay = 700,
		},
	},
	{
		"lukas-reineke/virt-column.nvim",
		ft = "markdown",
		opts = {
			char = "⋮",
		},
	},
}
