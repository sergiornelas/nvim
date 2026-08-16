return {
	"celeste3z/celeste_comment.nvim",
	lazy = false,
	opts = {
		mappings = {
			line_toggle_insert = "<c-g><c-c>",
			-- Insert comment below (n), example `gco`
			line_add_below = "gco",
			-- Insert comment above (n), example `gcO`
			line_add_above = "gcO",
			-- Insert comment at end of line (n), example `gcA`
			line_add_eol = "gcA",

			-- -- Invert comment per line (n, x), example `gcI`
			-- line_invert = "gcI",
			-- -- Force add line comment (n, x), example `gCC`
			-- line_force_add = "gCC",
			-- -- Force remove line comment (n, x), example `gCU`
			-- line_force_remove = "gCU",
		},
	},
}
