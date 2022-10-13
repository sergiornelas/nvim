-- init_options:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#html
return {
	init_options = {
		provideFormatter = false,
	},
	settings = {
		html = {
			hover = {
				documentation = true,
			},
		},
	},
}
