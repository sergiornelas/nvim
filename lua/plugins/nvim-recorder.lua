return {
	"chrisgrieser/nvim-recorder",
	event = "BufReadPre",
	config = function()
		require("recorder").setup({
			-- register/macro-slot used after startup.
			slots = { "a", "b" },
			-- Default keymaps
			mapping = {
				startStopRecording = "}",
				playMacro = "&",
				switchSlot = "<leader>&",
				editMacro = "cq",
				yankMacro = "qm", -- also decodes it for turning macros to mappings
				addBreakPoint = "]",
				-- addBreakPoint = "##", -- ⚠️ this should be a string you don't use in insert mode during a macro
			},
			-- clear all macros-slots on startup
			clear = false,
			-- log level used for any notification. Mostly relevant for nvim-notify.
			-- (Note that by default, nvim-notify does not show the levels trace and debug.)
			logLevel = vim.log.levels.INFO,
			-- experimental, see README
			dapSharedKeymaps = false,
		})
	end,
}
