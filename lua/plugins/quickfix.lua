-- BQF advantages
-- Is native, uses builtin vim quickfix features (return to previous/next quickfix, arbitrary commands with :cdo, filter results with fzf).
-- Is more confortable to navigate with than Trouble.nvim
-- * Navigate between files, not only via references
-- * No constantly folding/unfolding
-- See more buffers in the list
-- It is lighter
-- More aesthetic imo

return {
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		-- dependencies = { "junegunn/fzf" },
		config = function()
			require("bqf").setup({
				-- ⚠️  quickfix is opened in right column whenever vsplit (vanilla vim).
				-- is expected some irregularities with windows whenever you execute :copen
				preview = {
					win_height = 25, -- height of preview window for horizontal layout, large value (999) perform preview window as full model
				},
				func_map = {
					open = "O", -- open the item under the cursor
					openc = "o", --  open the item, and close quickfix window
					drop = "", -- use drop to open the item, and close quickfix window -- drop deletes arglist
					-- tabdrop use tab drop to open the item, and close quickfix window -- drop deletes arglist
					tab = "t", -- open the item in a new tab
					tabb = "T", -- open the item in a new tab, but stay in quickfix window
					tabc = "<c-t>", -- open the item in a new tab, and close quickfix window
					split = "<c-x>", --  open the item in horizontal split
					vsplit = "<c-v>", -- open the item in vertical split
					prevfile = "K", -- go to previous file under the cursor in quickfix window
					nextfile = "J", -- go to next file under the cursor in quickfix window
					prevhist = "<", -- cycle to previous quickfix list in quickfix window
					nexthist = ">", -- cycle to next quickfix list in quickfix window
					-- lastleave = '", -- go to last selected item in quickfix window
					stoggleup = "<c-p>", -- toggle sign and move cursor up
					stoggledown = "<c-n>", -- toggle sign and move cursor down
					stogglevm = "<tab>", -- toggle multiple signs in visual mode
					stogglebuf = "'<tab>", -- toggle signs for same buffers under the cursor
					sclear = "z<tab>", -- clear the signs in current quickfix list
					pscrollup = "<c-b>", --  scroll up half-page in preview window
					pscrolldown = "<c-f>", -- scroll down half-page in preview window
					pscrollorig = "zo", -- scroll back to original position in preview window
					ptogglemode = "<c-z>", -- toggle preview window between normal and max size
					ptoggleitem = "p", -- toggle preview for a quickfix list item
					ptoggleauto = "P", -- toggle auto-preview when cursor moves
					filter = "zn", -- create new list for signed items
					filterr = "zN", -- create new list for non-signed items
					fzffilter = "zf", -- enter fzf mode
				},
				filter = {
					fzf = {
						extra_opts = {
							default = { "--bind", "ctrl-o:up" },
						},
					},
				},
			})
		end,
	},
	{
		"stevearc/quicker.nvim",
		event = "FileType qf",
		config = function()
			require("quicker").setup({
				edit = {
					enabled = false,
				},
				-- slow with long reference list:
				highlight = {
					treesitter = true,
					lsp = false,
					load_buffers = false,
				},
				constrain_cursor = false,
				type_icons = {
					E = "",
					W = "",
					I = "",
					N = "󰎚",
					H = "",
				},
			})
		end,
	},
}
