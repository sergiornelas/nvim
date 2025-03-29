return {
	"jackplus-xyz/player-one.nvim",
	lazy = false,
	config = function()
		local Utils = require("player-one.utils")
		local State = require("player-one.state")

		local M = {}

		local function setup_cursormoved()
			if State._is_cursormoved_enabled then
				Utils._create_autocmds("CursorMoved", {
					wave_type = 1,
					base_freq = 140.0,
					env_attack = 0.0,
					env_sustain = 0.001,
					env_decay = 0.05,
				})
			end
		end

		function M.setup()
			setup_cursormoved()
		end

		M.setup()

		local my_theme = {
			{
				event = "VimEnter",
				sound = {
					{ wave_type = 1, base_freq = 359.25, env_attack = 0.0, env_sustain = 0.001, env_decay = 0.11 },
					{ wave_type = 1, base_freq = 483.99, env_attack = 0.0, env_sustain = 0.001, env_decay = 0.11 },
				},
				callback = function(sound)
					Utils.append(sound)
					vim.defer_fn(function()
						State._is_cursormoved_enabled = true
						setup_cursormoved()
					end, 300)
				end,
			},
			{
				event = "BufWritePost",
				sound = {
					{
						wave_type = 1,
						base_freq = 240.0,
						env_attack = 0.0,
						env_sustain = 0.001,
						env_decay = 0.05,
					},
					{
						wave_type = 1,
						base_freq = 340.0,
						env_attack = 0.0,
						env_sustain = 0.001,
						env_decay = 0.05,
					},
				},
				callback = "append",
			},
			{
				event = "TextChangedI",
				sound = {
					wave_type = 1,
					base_freq = 180.0,
					env_attack = 0.0,
					env_sustain = 0.001,
					env_decay = 0.05,
				},
			},
			{
				event = "TextYankPost",
				sound = {
					{ wave_type = 1, base_freq = 250.00, env_attack = 0.0, env_sustain = 0.001, env_decay = 0.05 },
				},
				callback = "append",
			},
			{
				event = "CmdlineEnter",
				sound = {
					wave_type = 1,
					base_freq = 200.0,
					env_attack = 0.0,
					env_sustain = 0.001,
					env_decay = 0.05,
				},
				callback = "play",
			},
			{
				event = "CmdlineChanged",
				sound = {
					wave_type = 1,
					base_freq = 200.0,
					env_attack = 0.0,
					env_sustain = 0.001,
					env_decay = 0.05,
				},
				callback = "play",
			},
		}

		require("player-one").setup({
			-- 	---Available presets: "chiptune", "crystal", "synth"
			theme = my_theme,
			-- 	min_interval = 0.1, -- Increase delay between sounds to 100ms
		})
	end,
}
