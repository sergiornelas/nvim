return {
	{
		"eandrju/cellular-automaton.nvim",
		cmd = "CellularAutomaton",
		keys = {
			{
				"<leader>C",
				"<cmd>CellularAutomaton make_it_rain<cr>",
			},
		},
	},
	{
		"alanfortlink/animatedbg.nvim",
		config = true,
		keys = {
			{
				"<leader>F",
				"<cmd>lua require('animatedbg-nvim').play({ animation = 'fireworks' })<cr>",
			},
			{
				"<leader>M",
				"<cmd>lua require('animatedbg-nvim').play({ animation = 'matrix' })<cr>",
			},
			{
				"<leader>B",
				"<cmd>lua require('animatedbg-nvim').play({ animation = 'demo' })<cr>",
			},
			{
				"<leader>S",
				"<cmd>lua require('animatedbg-nvim').stop_all()<cr>",
			},
		},
	},
	{
		"seandewar/killersheep.nvim",
		keys = {
			{
				"<leader>`",
				"<cmd>KillKillKill<cr>",
			},
		},
	},
	{
		"EggbertFluffle/beepboop.nvim",
		lazy = false,
		opts = {
			audio_player = "afplay",
			max_sounds = 20,
			sound_map = {
				{ auto_command = "VimEnter", sound = "dsbdopn.wav" },
				{ auto_command = "VimLeavePre", sound = "dsswtchx.wav" },
				{ auto_command = "SessionWritePost", sound = "dsswtchn.wav" },
				{
					auto_command = { "InsertCharPre", "InsertEnter" },
					sounds = { "stone1.mp3", "stone2.mp3", "stone3.mp3" },
				},
				{
					trigger_name = "save_sound",
					sound = "dsitemup.wav",
				},
				{
					trigger_name = "open_notes",
					sound = "dspstop.wav",
				},
			},
		},
	},
}
