return {
	"nickjvandyke/opencode.nvim",
	enabled = false,
	dependencies = {
		{
			-- `snacks.nvim` integration is recommended, but optional
			---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
			"folke/snacks.nvim",
			optional = true,
			opts = {
				input = {}, -- Enhances `ask()`
				picker = { -- Enhances `select()`
					actions = {
						opencode_send = function(...)
							return require("opencode").snacks_picker_send(...)
						end,
					},
					win = {
						input = {
							keys = {
								["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
							},
						},
					},
				},
			},
		},
	},
	config = function()
		---@type opencode.Opts
		vim.g.opencode_opts = {
			-- Your configuration, if any; goto definition on the type or field for details
		}

		vim.o.autoread = true -- Required for `opts.events.reload`

		-- keymap: gb free

		local kitty = require("config.kitty-opencode")

		local keymap = vim.keymap.set

		keymap({ "n", "x" }, "ga", function() -- (vim: print ascii value of character under the cursor)
			kitty.with_opencode(function(opencode)
				opencode.ask("@this: ", { submit = true })
			end)
		end, { desc = "Ask OpenCode @this" })

		keymap({ "n", "x" }, "gh", function() -- (vim: start Select mode)
			kitty.with_opencode(function(opencode)
				opencode.select()
			end)
		end, { desc = "OpenCode select" })

		-- keymap({ "n", "t" }, "<C-.>", function()
		-- 	opencode.toggle()
		-- end, { desc = "Toggle opencode" })

		keymap("x", "gl", function()
			return kitty.with_opencode_expr(function(opencode)
				return opencode.operator("@this ")
			end)
		end, { expr = true, desc = "Add range to OpenCode" })

		keymap("n", "gll", function()
			return kitty.with_opencode_expr(function(opencode)
				return opencode.operator("@this ") .. "_"
			end)
		end, { expr = true, desc = "Add line to OpenCode" })

		-- keymap("n", "<S-C-u>", function()
		-- 	opencode.command("session.half.page.up")
		-- end, { desc = "Scroll opencode up" })

		-- keymap("n", "<S-C-d>", function()
		-- 	opencode.command("session.half.page.down")
		-- end, { desc = "Scroll opencode down" })

		-- Extras -----------------
		keymap({ "n", "x" }, "go", function() -- (vim: cursor to byte N in the buffer)
			kitty.with_opencode(function(opencode)
				opencode.ask("@buffer: ", { submit = true })
			end)
		end, { desc = "Ask OpenCode current buffer" })

		-- BUG: doesn't use the current buffer list, only takes the current session opened buffers
		keymap({ "n", "x" }, "gO", function() -- (vim: document symbols)
			kitty.with_opencode(function(opencode)
				opencode.ask("@buffers: ", { submit = true })
			end)
		end, { desc = "Ask OpenCode open buffers" })

		keymap({ "n", "x" }, "g<CR>", function()
			kitty.with_opencode(function(opencode)
				opencode.ask("@grapple: ", { submit = true })
			end)
		end, { desc = "Ask OpenCode grappled files" })
	end,
}
