return {
	"saghen/blink.cmp",
	event = "InsertEnter",
	version = "1.*",
	dependencies = {
		{ "L3MON4D3/LuaSnip", version = "v2.*" },
		{ "rafamadriz/friendly-snippets" },
		{ "xieyonn/blink-cmp-dat-word" },
	},
	---@module 'blink.cmp'
	---@diagnostic disable-next-line: undefined-doc-name
	---@type blink.cmp.Config
	opts = {
		cmdline = {
			-- mini.cmdline does a better job (v0.11):
			enabled = false,
			keymap = {
				["<c-o>"] = { "select_prev" },
			},
		},
		completion = {
			menu = {
				draw = {
					components = {
						label = {
							width = { fill = true, max = 33 },
						},
						kind_icon = {
							text = function(ctx)
								if ctx.source_name == "Word" then
									return "" .. ctx.icon_gap
								else
									return ctx.kind_icon .. ctx.icon_gap
								end
							end,
						},
					},
					treesitter = {
						"lsp",
					},
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 0,
			},
			ghost_text = {
				enabled = false,
			},
		},
		sources = {
			-- Static list of providers to enable, or a function to dynamically enable/disable providers based on the context
			default = { "lsp", "path", "snippets", "buffer" },
			per_filetype = {
				markdown = { "path", "snippets", "buffer", "datword" },
			},
			providers = {
				datword = {
					name = "Word",
					module = "blink-cmp-dat-word",
					opts = {
						paths = {
							-- "path_to_your_words.txt", -- add your owned word files before dictionary.
							"/usr/share/dict/words", -- This file is included by default on Linux/macOS.
						},
					},
				},
				path = {
					opts = {
						show_hidden_files_by_default = false,
					},
				},
				snippets = {
					opts = {
						extended_filetypes = {
							-- Avoiding duplicates:
							-- javascriptreact includes js, jsx and html snippets
							js = { "css", "javascriptreact" },
							javascriptreact = { "css" },
							-- typescriptreact includes ts and tsx snippets
							ts = { "html", "css", "typescriptreact" },
							typescriptreact = { "html", "css" },
						},
						ignored_filetypes = { "javascript", "typescript" },
						get_filetype = function()
							if vim.bo.filetype == "javascript" then
								return "js"
							end
							if vim.bo.filetype == "typescript" then
								return "ts"
							end
							return vim.bo.filetype
						end,
					},
				},
			},
		},
		snippets = {
			expand = function(snippet)
				require("luasnip").lsp_expand(snippet)
			end,
			active = function(filter)
				if filter and filter.direction then
					return require("luasnip").jumpable(filter.direction)
				end
				return require("luasnip").in_snippet()
			end,
			jump = function(direction)
				require("luasnip").jump(direction)
			end,
		},
		-- Experimental signature help support
		signature = {
			enabled = true,
		},
		keymap = {
			preset = "none",
			-- Important!: use C-x in caps, c-x doesn't work
			["<C-'>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-space>"] = { "hide", "fallback" },
			["<C-j>"] = { "select_and_accept", "fallback" },

			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },

			["<C-,>"] = { "scroll_documentation_up", "fallback" },
			["<C-.>"] = { "scroll_documentation_down", "fallback" },

			["<C-v>"] = { "snippet_forward", "fallback" },
			["<C-b>"] = { "snippet_backward", "fallback" },

			["<C-k>"] = { "show_signature", "hide_signature", "fallback" }, -- (vim: enter digraph)
		},
		appearance = {
			-- Sets the fallback highlight groups to nvim-cmp's highlight groups
			-- Useful for when your theme doesn't support blink.cmp
			-- Will be removed in a future release
			use_nvim_cmp_as_default = true,
		},
	},
}
