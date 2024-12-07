-- > brew install imagemagick
-- > brew info imagemagick
-- if pkgconf is missing:
-- > brew install pkg-config
-- for pasting images from the clipboard:
-- > brew install pngpaste

return {
	{
		"3rd/image.nvim",
		ft = { "markdown", "html", "css" },
		opts = {
			integrations = {
				markdown = {
					only_render_image_at_cursor = false,
					floating_windows = false,
					filetypes = { "markdown", "vimwiki" },
				},
				neorg = {
					enabled = false,
				},
				typst = {
					enabled = false,
				},
				html = {
					enabled = true,
				},
				css = {
					enabled = true,
				},
			},
			-- max_height_window_percentage = 75,
			hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
		},
	},
	{
		"HakonHarnes/img-clip.nvim",
		keys = {
			{ "<leader>P", "<cmd>PasteImage<cr>" },
		},
		opts = {
			default = {
				dir_path = function()
					return vim.fn.expand("~") .. "/notes/images/"
				end,
			},
		},
	},
}
