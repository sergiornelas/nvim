return {
	"bloznelis/buftrack.nvim",
	event = "BufEnter",
	config = function()
		local buftrack = require("buftrack")
		buftrack.setup({
			max_tracked = 16,
		})
		-- Not required but recommended. Once you start inserting text,
		-- this will move the current buffer to the top of the tracklist.
		vim.api.nvim_create_autocmd({ "InsertEnter" }, {
			callback = buftrack.track_buffer,
		})
	end,
}
