return {
	{
		"cajames/copy-reference.nvim",
		opts = {},
		keys = {
			{ "<leader>y", "<cmd>CopyReference file<cr>", mode = { "n", "v" }, desc = "Copy file path" },
			{ "<leader>Y", "<cmd>CopyReference line<cr>", mode = { "n", "v" }, desc = "Copy file:line reference" },
		},
	},
	{
		"NickvanDyke/opencode.nvim",
		dependencies = {
			---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
			{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
		},
		config = function()
			vim.g.opencode_opts = {
				provider = {
					enabled = "kitty",
				},
			}

			-- Required for `opts.events.reload`.
			vim.o.autoread = true

			local tall_layout = function()
				-- instead of go-to-layout tall, go to previous layout
				vim.fn.jobstart({ "kitty", "@", "goto-layout", "tall" })
			end

			-- gb free

			local keymap = vim.keymap.set

			keymap({ "n", "x" }, "ga", function() -- (vim: print ascii value of character under the cursor)
				tall_layout()
				require("opencode").ask("@this: ", { submit = true })
			end, { desc = "Ask opencode" })

			keymap({ "n", "x" }, "gh", function() -- (vim: start Select mode)
				tall_layout()
				require("opencode").select()
			end, { desc = "Execute opencode action…" })

			keymap("x", "gl", function()
				tall_layout()
				return require("opencode").operator("@this ")
			end, { expr = true, desc = "Add range to opencode" })

			keymap("n", "gll", function()
				tall_layout()
				return require("opencode").operator("@this ") .. "_"
			end, { expr = true, desc = "Add line to opencode" })

			-- Extras -----------------
			keymap({ "n", "x" }, "go", function() -- (vim: cursor to byte N in the buffer)
				tall_layout()
				require("opencode").ask("@buffer: ", { submit = true })
			end, { desc = "Ask opencode current buffer" })

			-- BUG: doesn't use the current buffer list, only takes the current session opened buffers
			keymap({ "n", "x" }, "gO", function()
				tall_layout()
				require("opencode").ask("@buffers: ", { submit = true })
			end, { desc = "Ask opencode open buffers" })

			keymap({ "n", "x" }, "g<return>", function()
				tall_layout()
				require("opencode").ask("@grapple: ", { submit = true })
			end, { desc = "Ask opencode current grappled files" })
		end,
	},
}
