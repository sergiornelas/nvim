local present, bufferline = pcall(require, "bufferline")
if not present then
	return
end

bufferline.setup({
	options = {
		show_buffer_close_icons = false,
		show_close_icon = false,
		always_show_bufferline = true,
		offsets = { { filetype = "NvimTree", text = "File Explorer" } },
		tab_size = 1,
	},
})
