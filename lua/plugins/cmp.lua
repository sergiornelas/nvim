-- replace cmp with new builtin completion, future reference:
-- https://www.reddit.com/r/neovim/comments/1d7j0c1/a_small_gist_to_use_the_new_builtin_completion/
-- https://gist.github.com/MariaSolOs/2e44a86f569323c478e5a078d0cf98cc

local M = {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			{ "allaman/emoji.nvim", opts = { enable_cmp_integration = true } },
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-calc",
		},
		config = function()
			local cmp_ok, cmp = pcall(require, "cmp")
			local luasnip_ok, luasnip = pcall(require, "luasnip")
			local lspkind_ok, lspkind = pcall(require, "lspkind")

			if not cmp_ok or not luasnip_ok or not lspkind_ok then
				return
			end

			-- Add React snippets to js|ts files
			-- Add HTML and CSS snippets to js|jsx|ts|tsx files
			luasnip.filetype_set("javascript", { "javascriptreact" })
			luasnip.filetype_set("typescript", { "typescriptreact" })
			luasnip.filetype_extend("javascript", { "html", "css" })
			luasnip.filetype_extend("javascriptreact", { "html", "css" })
			luasnip.filetype_extend("typescript", { "html", "css" })
			luasnip.filetype_extend("typescriptreact", { "html", "css" })
			luasnip.filetype_extend("mjml", { "html", "css" })

			require("luasnip.loaders.from_vscode").lazy_load()

			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			luasnip.setup({
				region_check_events = "CursorMoved", -- snippets get deleted once you delete the block (buggy)
			})

			cmp.setup({
				view = {
					entries = {
						follow_cursor = true,
					},
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<c-,>"] = cmp.mapping.scroll_docs(-4),
					["<c-.>"] = cmp.mapping.scroll_docs(4),
					["<c-'>"] = cmp.mapping.complete(),
					["<c-l>"] = cmp.mapping.abort(),
					["<c-e>"] = vim.NIL, -- (vim: insert the character which is below the cursor)
					-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items:
					["<c-j>"] = cmp.mapping.confirm({ select = true }),
					["<c-n>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif has_words_before() then
							fallback()
							-- cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<c-p>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<c-v>"] = cmp.mapping(function() -- (vim: insert next non-digit literally, same as c-q)
						luasnip.expand_or_jump()
					end, { "i", "s" }),
					["<c-b>"] = cmp.mapping(function()
						luasnip.jump(-1)
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "calc" },
					{ name = "path" },
					-- { name = "buffer", keyword_length = 5 },
				},
				sorting = {
					-- determines the order in which cmp shows you it's entries.
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						cmp.config.compare.kind,
					},
				},
				formatting = {
					format = lspkind.cmp_format({
						maxwidth = 30,
						ellipsis_char = "...",
						-- avoids duplicate results
						-- before = function(entry, vim_item)
						-- vim_item.dup = { buffer = 1, path = 1, nvim_lsp = 0 }
						-- return vim_item
						-- end,
					}),
				},
			})
			-- If you want insert `(` after select function or method item
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
}

return M
