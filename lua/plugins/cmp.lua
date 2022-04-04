local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, ls = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

ls.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
})

-- ADD HTML, CSS (Styled components) AND JS SNIPPETS TO JAVASCRIPT/TYPESCRIPT/REACT files
-- (filetype_set) in a js file: search javascriptreact-snippets, then all-snippets only (no javascript-snippets!).
ls.filetype_set("javascript", { "javascriptreact" })
ls.filetype_extend("javascript", { "html", "css" })
ls.filetype_extend("javascriptreact", { "html", "css" })
ls.filetype_set("typescript", { "typescriptreact" })
ls.filetype_extend("typescript", { "html", "css" })
ls.filetype_extend("typescriptreact", { "html", "css" })

require("luasnip/loaders/from_vscode").load({})
-- require("luasnip.loaders.from_vscode").load({})

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

--   פּ ﯟ   some other good icons
local kind_icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup({
	snippet = {
		expand = function(args)
			ls.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = {
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<C-j>"] = cmp.mapping.confirm({ select = true }),
		["<C-k>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif ls.expandable() then
				ls.expand()
			elseif ls.expand_or_jumpable() then
				ls.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<C-l>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif ls.jumpable(-1) then
				ls.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			vim_item.abbr = string.sub(vim_item.abbr, 1, 20)
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				nvim_lua = "[NVIM_LUA]",
				luasnip = "[Snippet]",
				buffer = "[Buffer]",
				path = "[Path]",
				neorg = "[Neorg]",
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = {
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "neorg" },
		{ name = "nvim_lua" },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	documentation = {
		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	},
	experimental = {
		ghost_text = false,
		native_menu = false,
	},
})
