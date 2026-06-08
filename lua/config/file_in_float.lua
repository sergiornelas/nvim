local api = vim.api
local fn = vim.fn

api.nvim_set_hl(0, "ScratchBackdrop", { bg = "#000000", default = true })

local window_id, backdrop_id, backdrop_buf

function _G.close_file_in_float()
	if not (window_id and api.nvim_win_is_valid(window_id)) then
		return false
	end
	local w, b = window_id, backdrop_id
	window_id, backdrop_id = nil, nil
	pcall(api.nvim_win_close, w, true)
	if b then
		pcall(api.nvim_win_close, b, true)
	end
	return true
end

function _G.promote_file_in_float_to_split()
	if not (window_id and api.nvim_win_is_valid(window_id)) then
		return false
	end
	local bufnr = api.nvim_win_get_buf(window_id)
	local cursor = api.nvim_win_get_cursor(window_id)
	if backdrop_id then
		pcall(api.nvim_win_close, backdrop_id, true)
		backdrop_id = nil
	end
	pcall(api.nvim_win_close, window_id, true)
	vim.cmd("split")
	window_id = api.nvim_get_current_win()
	api.nvim_set_current_buf(bufnr)
	api.nvim_win_set_cursor(window_id, cursor)
	return true
end

function _G.toggle_file_in_float(filepath)
	-- Close
	if _G.close_file_in_float() then
		return
	end
	-- Backdrop (dims the editor behind the float)
	if not (backdrop_buf and api.nvim_buf_is_valid(backdrop_buf)) then
		backdrop_buf = api.nvim_create_buf(false, true)
	end
	backdrop_id = api.nvim_open_win(backdrop_buf, false, {
		relative = "editor",
		row = 0,
		col = 0,
		width = vim.o.columns,
		height = vim.o.lines,
		style = "minimal",
		border = "none",
		focusable = false,
		zindex = 49,
	})
	vim.wo[backdrop_id].winhighlight = "Normal:ScratchBackdrop"
	vim.wo[backdrop_id].winblend = 50
	-- Floating window
	local full_filepath = fn.expand(filepath)
	local bufnr = fn.bufadd(full_filepath)
	fn.bufload(bufnr)
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	window_id = api.nvim_open_win(bufnr, true, {
		relative = "editor",
		width = width,
		height = height,
		row = math.floor((vim.o.lines - height) / 2),
		col = math.floor((vim.o.columns - width) / 2),
		border = "single",
		title = " " .. fn.fnamemodify(full_filepath, ":t") .. " ",
		title_pos = "center",
		zindex = 50,
	})
	vim.wo[window_id].cursorline = true
	vim.wo[window_id].colorcolumn = "80"
	vim.wo[window_id].winbar = " %{%v:lua.require'nvim-navic'.get_location()%}"
	-- Cleanup backdrop and state when floating window is closed by any means
	api.nvim_create_autocmd("WinClosed", {
		pattern = tostring(window_id),
		once = true,
		callback = function()
			if backdrop_id and api.nvim_win_is_valid(backdrop_id) then
				api.nvim_win_close(backdrop_id, true)
			end
			window_id = nil
			backdrop_id = nil
		end,
	})
end
