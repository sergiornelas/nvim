local status_ok, incline = pcall(require, "incline")
if not status_ok then
	return
end

incline.setup({
	window = {
		margin = {
			horizontal = 0,
			vertical = 0,
		},
		padding = 1,
		padding_char = " ",
		placement = {
			horizontal = "right",
			vertical = "bottom",
		},
	},
})
