local present, colorizer = pcall(require, "colorizer")

if present then
	colorizer.setup({ "*" }, {
		RGB = true, -- #RGB hex codes
		RRGGBB = true, -- #RRGGBB hex codes
		mode = "foreground", -- Set the display mode.
	})
end
