return {
	"Mirsmog/real-icons.nvim",
	build = ":RealIconsInstallPack material",
	event = "VeryLazy",
	opts = {
		pack = "material",
		backend = "kitty",
		integrations = {
			mini_files = true,
			snacks_picker = true,
			-- lualine custom integration
			lualine = false,
		},
	},
}
