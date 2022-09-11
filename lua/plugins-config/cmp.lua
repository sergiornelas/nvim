local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, ls = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

-- Add React snippets to .js/.ts files
-- Add HTML and CSS snippets to .js/.jsx/.ts/.tsx files
ls.filetype_set("javascript", { "javascriptreact" })
ls.filetype_set("typescript", { "typescriptreact" })
ls.filetype_extend("javascript", { "html", "css" })
ls.filetype_extend("javascriptreact", { "html", "css" })
ls.filetype_extend("typescript", { "html", "css" })
ls.filetype_extend("typescriptreact", { "html", "css" })

require("luasnip.loaders.from_vscode").lazy_load()

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

ls.setup({
	history = false,
	region_check_events = "CursorMoved",
})

local kind_icons = {
	Class = "",
	Color = "",
	Constant = "",
	Constructor = "",
	Enum = "",
	EnumMember = "",
	Event = "",
	Field = "",
	File = "",
	Folder = "",
	Function = "",
	Interface = "",
	Keyword = "",
	Method = "m",
	Module = "",
	Operator = "",
	Property = "",
	Reference = "",
	Snippet = "",
	Struct = "",
	Text = "",
	TypeParameter = "",
	Unit = "",
	Value = "",
	Variable = "",
}

local source_mapping = {
	nvim_lsp = "[LSP]",
	luasnip = "[Snippet]",
	buffer = "[Buffer]",
	path = "[Path]",
	neorg = "[Neorg]",
	emoji = "[Emoji]",
}

cmp.setup({
	snippet = {
		expand = function(args)
			ls.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = {
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-f>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- Accept currently selected item. If none selected, `select` first item.
		["<C-j>"] = cmp.mapping.confirm({ select = true }),
		["<C-i>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif ls.expand_or_jumpable() then
				ls.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-o>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif ls.jumpable(-1) then
				ls.jump(-1)
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
	formatting = {
		format = function(entry, vim_item)
			-- vim_item.dup = { buffer = 1, path = 1, nvim_lsp = 0 } -- avoids duplicates
			-- Kind icons
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			vim_item.abbr = string.sub(vim_item.abbr, 1, 22)
			local menu = source_mapping[entry.source.name]
			vim_item.menu = menu
			return vim_item
		end,
	},
	experimental = {
		ghost_text = true,
	},
})
