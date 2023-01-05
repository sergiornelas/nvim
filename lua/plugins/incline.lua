local M = {
	"b0o/incline.nvim",
	event = "BufReadPre",
}

function M.config()
	local incline_ok, incline = pcall(require, "incline")
	if not incline_ok then
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
end
return M
