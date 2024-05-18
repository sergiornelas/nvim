return {
	{
		"pmizio/typescript-tools.nvim",
		event = { "BufReadPre *.ts,*.tsx,*.js,*.jsx", "BufNewFile *.ts,*.tsx,*.js,*.jsx" },
		keys = {
			{ "<leader>tto", "<cmd>TSToolsOrganizeImports<cr>" },
			{ "<leader>tts", "<cmd>TSToolsSortImports<cr>" },
			{ "<leader>ttu", "<cmd>TSToolsRemoveUnusedImports<cr>" },
			{ "<leader>ttd", "<cmd>TSToolsRemoveUnused<cr>" },
			{ "<leader>tti", "<cmd>TSToolsAddMissingImports<cr>" },
			{ "<leader>tta", "<cmd>TSToolsFixAll<cr>" },
			{ "<leader>ttr", "<cmd>TSToolsRenameFile<cr>" },
			{ "<leader>ttf", "<cmd>TSToolsFileReferences<cr>" },
		},
		dependencies = { "nvim-lua/plenary.nvim", "nvim-lspconfig" },
		config = function()
			require("typescript-tools").setup({
				on_attach = require("plugins.lsp.handlers").on_attach,
				settings = {
					-- spawn additional tsserver instance to calculate diagnostics on it
					separate_diagnostic_server = true,
					-- "change"|"insert_leave" determine when the client asks the server about diagnostic
					publish_diagnostic_on = "insert_leave",
					-- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
					-- "remove_unused_imports"|"organize_imports") -- or string "all"
					-- to include all supported code actions
					-- specify commands exposed as code_actions
					expose_as_code_action = {},
					-- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
					-- not exists then standard path resolution strategy is applied
					tsserver_path = nil,
					-- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
					tsserver_plugins = {
						-- npm i -g @styled/typescript-styled-plugin typescript-styled-plugin (deprecated)
						-- for TypeScript v4.9+
						"@styled/typescript-styled-plugin",
						-- or for older TypeScript versions
						-- "typescript-styled-plugin",
					},
					-- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
					-- memory limit in megabytes or "auto"(basically no limit)
					tsserver_max_memory = "auto",
					-- described below
					tsserver_format_options = {},
					tsserver_file_preferences = require("plugins.lsp.settings.tsserver"),
					-- locale of all tsserver messages, supported locales you can find here:
					-- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
					tsserver_locale = "en",
					-- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
					complete_function_calls = false,
					include_completions_with_insert_text = true,
					-- CodeLens
					-- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
					-- possible values: ("off"|"all"|"implementations_only"|"references_only")
					code_lens = "off",
					-- by default code lenses are displayed on all referencable values and for some of you it can
					-- be too much this option reduce count of them by removing member references from lenses
					disable_member_code_lens = true,
					-- JSXCloseTag
					-- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-auto-tag,
					-- that maybe have a conflict if enable this feature. )
					jsx_close_tag = {
						enable = false,
						filetypes = { "javascriptreact", "typescriptreact" },
					},
				},
			})

			-- Styled components IntelliSense:
			-- ----------------------
			-- npm install styled-components
			-- npm install --save-dev @styled/typescript-styled-plugin typescript
			-- tsconfig.json:
			-- {
			--   "compilerOptions": {
			--     "plugins": [
			--       {
			--         "name": "@styled/typescript-styled-plugin",
			--         "tags": ["styled", "css", "sty"],
			--         "lint": {
			--           "duplicateProperties": "warning",
			--           "emptyRules": "warning",
			--           "boxModel": "warning",
			--           "universalSelector": "warning",
			--           "zeroUnits": "warning",
			--           "important": "warning",
			--           "float": "warning",
			--           "idSelector": "warning"
			--         }
			--       }
			--     ]
			--   }
			-- }

			-- Workaround for truncating long TypeScript inlay hints.
			-- TODO: Remove this if https://github.com/neovim/neovim/issues/27240 gets addressed.
			-- https://github.com/MariaSolOs/dotfiles/blob/88646ab9bd20d6f36dacea0cdee8b6af3ffc4c50/.config/nvim/lua/lsp.lua#L275-L292
			local methods = vim.lsp.protocol.Methods
			local inlay_hint_handler = vim.lsp.handlers[methods.textDocument_inlayHint]
			vim.lsp.handlers[methods.textDocument_inlayHint] = function(err, result, ctx, config)
				local client = vim.lsp.get_client_by_id(ctx.client_id)
				if client and client.name == "typescript-tools" then
					result = vim.iter(result)
						:map(function(hint)
							local label = hint.label ---@type string
							if label:len() >= 30 then
								label = label:sub(1, 29) .. "…"
							end
							hint.label = label
							return hint
						end)
						:totable()
				end

				inlay_hint_handler(err, result, ctx, config)
			end
		end,
	},
	{
		-- Justification: tsserver doesn’t handle project wide diagnostics very well, and existing solutions were not async.
		-- Project wide diagnostics means that if you have errors in any of the project files
		-- (even if they're not open in buffers) they're reported.
		-- If you don't have project wide diagnostics errors are only reported on the files you have open.
		-- tsserver has an experimental configuration option called: enableProjectDiagnostics. This has been "experimental"
		-- for a few years at this point, and generally either locks up the editor or flat out doesn't work.
		"dmmulroy/tsc.nvim",
		config = true,
		keys = {
			{
				"<leader>TP",
				"<cmd>TSC<cr>",
			},
		},
	},
	{
		"dmmulroy/ts-error-translator.nvim",
		ft = { "typescript", "typescriptreact" },
		config = function()
			require("ts-error-translator").setup()
		end,
	},
}
