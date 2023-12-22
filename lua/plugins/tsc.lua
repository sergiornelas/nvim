-- Justification: tsserver doesn’t handle project wide diagnostics very well, and existing solutions were not async.
-- Project wide diagnostics means that if you have errors in any of the project files
-- (even if they're not open in buffers) they're reported.
-- If you don't have project wide diagnostics errors are only reported on the files you have open.
-- tsserver has an experimental configuration option called: enableProjectDiagnostics. This has been "experimental"
-- for a few years at this point, and generally either locks up the editor or flat out doesn't work.

return {
	"dmmulroy/tsc.nvim",
	config = true,
	keys = {
		{
			"<leader>TS",
			"<cmd>TSC<cr>",
		},
	},
}
