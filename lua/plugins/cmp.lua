local M = {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-emoji",
			"onsails/lspkind.nvim",
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
				history = false,
				region_check_events = "CursorMoved",
			})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = {
					["<c-u>"] = cmp.mapping.scroll_docs(-4),
					["<c-d>"] = cmp.mapping.scroll_docs(4),
					["<c-f>"] = cmp.mapping({
						i = cmp.mapping.abort(),
						c = cmp.mapping.close(),
					}),
					-- Accept currently selected item. If none selected, `select` first item.
					["<c-j>"] = cmp.mapping.confirm({ select = true }),
					["<c-i>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<c-o>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "neorg" },
					{ name = "emoji" },
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
		event = "InsertEnter",
	},
}

return M
