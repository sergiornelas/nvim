local M = {
	"NvChad/nvim-colorizer.lua",
}

function M.config()
	local colorizer_ok, colorizer = pcall(require, "colorizer")
	if not colorizer_ok then
		return
	end

	colorizer.setup({
		filetypes = { "*" },
		names = false, -- "Name" codes like blue
		RGB = true, -- #RGB hex codes
		RRGGBB = true, -- #RRGGBB hex codes
		RRGGBBAA = true, -- #RRGGBBAA hex codes
		rgb_fn = true, -- CSS rgb() and rgba() functions
		hsl_fn = true, -- CSS hsl() and hsla() functions
		css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
		css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
		mode = "background", -- Set the display mode.
	})
end

return M
