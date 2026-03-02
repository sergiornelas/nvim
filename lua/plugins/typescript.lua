-- Organize imports on save
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
-- 	callback = function()
-- 		vim.lsp.buf.code_action({
-- 			context = {
-- 				diagnostics = {},
-- 				---@diagnostic disable-next-line: assign-type-mismatch
-- 				only = { "source.sortImports" },
-- 			},
-- 			apply = true,
-- 		})
-- 	end,
-- })

local function ts_source_action(key, action)
	vim.keymap.set("n", key, function()
		vim.lsp.buf.code_action({
			context = {
				diagnostics = {},
				only = { action },
			},
			apply = true,
		})
	end, { silent = true })
end

-- Disable: Language server `vtsls` does not support command `_typescript.didOrganizeImports`.
vim.lsp.commands["_typescript.didOrganizeImports"] = function() end

-- Organize Imports
ts_source_action("<leader>tto", "source.organizeImports")
-- Sort Imports
ts_source_action("<leader>tts", "source.sortImports")
-- Remove Unused Imports
ts_source_action("<leader>ttu", "source.removeUnusedImports")
-- Add Missing Imports
ts_source_action("<leader>tta", "source.addMissingImports.ts")

return {
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
				"<leader>X",
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
	{
		"nemanjamalesija/ts-expand-hover.nvim",
		ft = { "typescript", "typescriptreact" },
		config = function()
			require("ts_expand_hover").setup({
				keymaps = {
					hover = false,
					expand = ">",
					collapse = "<",
				},
				float = {
					border = "single",
				},
			})

			vim.keymap.set("n", "<leader>th", require("ts_expand_hover").hover)
		end,
	},
	-- Useful if you decide to use pure tsgo and no vtsls:
	-- {
	-- 	"Sebastian-Nielsen/better-type-hover",
	-- 	ft = { "typescript", "typescriptreact" },
	-- 	config = function()
	-- 		require("better-type-hover").setup({
	-- 			openTypeDocKeymap = "<c-\\>",
	-- 		})
	-- 	end,
	-- },
}
