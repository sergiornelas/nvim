local api = vim.api
local fn = vim.fn

api.nvim_set_hl(0, "ScratchBackdrop", { bg = "#000000", default = true })

-- Persisted view state per file (cursor + scroll + fold) across nvim sessions
local VIEW_FILE = fn.stdpath("data") .. "/scratch_views.json"

local function load_views()
	if fn.filereadable(VIEW_FILE) == 0 then
		return {}
	end
	local ok, views = pcall(vim.json.decode, fn.readfile(VIEW_FILE)[1] or "")
	return (ok and type(views) == "table") and views or {}
end

local function save_view(filepath, view)
	local views = load_views()
	views[filepath] = view
	fn.writefile({ vim.json.encode(views) }, VIEW_FILE)
end

local window_id, backdrop_id, backdrop_buf

function _G.toggle_file_in_float(filepath)
	-- Close
	if window_id and api.nvim_win_is_valid(window_id) then
		local file = api.nvim_buf_get_name(api.nvim_win_get_buf(window_id))
		save_view(file, api.nvim_win_call(window_id, fn.winsaveview))
		api.nvim_win_close(window_id, true)
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
		border = "rounded",
		title = " " .. fn.fnamemodify(full_filepath, ":t") .. " ",
		title_pos = "center",
		zindex = 50,
	})
	local view = load_views()[full_filepath]
	if view then
		fn.winrestview(view)
	end
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
