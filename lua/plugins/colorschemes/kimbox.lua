local kimbox_ok, kimbox = pcall(require, "kimbox")
if not kimbox_ok then
	return
end

kimbox.setup({
	toggle_style_key = "<leader>%",
	allow_italic = true,
	allow_underline = true,
	transparent = false,
})
