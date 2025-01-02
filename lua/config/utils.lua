local cmd = vim.cmd
local api = vim.api
local fn = vim.fn

-- Toggle true/false
function _G.toggle_boolean()
	local line = api.nvim_get_current_line()
	local new_line = line:gsub("true", "TEMP"):gsub("false", "true"):gsub("TEMP", "false")
	api.nvim_set_current_line(new_line)
end

-- Close all terminal buffers when exit (auto-session)
function _G.close_all_terminals()
	for _, buf in ipairs(api.nvim_list_bufs()) do
		if vim.bo[buf].buftype == "terminal" then
			api.nvim_buf_delete(buf, { force = true })
		end
	end
end

-- Closes TSContext and Fidget (floating windows) when exit (auto-session)
function _G.close_floating_windows()
	for _, win in ipairs(api.nvim_list_wins()) do
		local config = api.nvim_win_get_config(win)
		if config.relative ~= "" then
			api.nvim_win_close(win, false)
		end
	end
end

-- Toggle scratch file
function _G.toggle_file_in_split(filepath)
	-- If filepath arg is not present (auto-session)
	if not filepath then
		local path = "~/notes/scratch/main.md"
		if fn.bufnr(path) ~= -1 then
			-- it exists
			cmd("normal! mz")
			cmd("bd" .. path)
		end
		return
	end
	_G.file_windows = _G.file_windows or {}
	local current_tab_id = api.nvim_get_current_tabpage()
	_G.file_windows[current_tab_id] = _G.file_windows[current_tab_id] or {}
	local window_id = _G.file_windows[current_tab_id].window_id
	local last_file = _G.file_windows[current_tab_id].last_file or filepath
	-- Close window
	if window_id and api.nvim_win_is_valid(window_id) then
		cmd("w")
		-- Store the current file path before closing the window
		_G.file_windows[current_tab_id].last_file = api.nvim_buf_get_name(api.nvim_win_get_buf(window_id))
		cmd("normal! mz")
		api.nvim_win_close(window_id, true)
		cmd("wincmd p")
	else
		-- Open file
		local RESIZE_AMOUNT = 6
		local full_filepath = fn.expand(last_file)
		cmd("keepalt split " .. filepath)
		cmd("e" .. full_filepath)
		window_id = api.nvim_get_current_win()
		cmd("keepjumps normal! `z")
		cmd("wincmd J")
		cmd("resize +" .. RESIZE_AMOUNT .. " | wincmd p | wincmd p")
		cmd("normal! zz")
	end
	-- Update window ID in file_windows table
	_G.file_windows[current_tab_id].window_id = window_id and api.nvim_win_is_valid(window_id) and window_id or nil
end

-- Equalize windows width (not height) through all tabs when resizing Vim
-- Function to fix or unfix the window heights for all windows in a tab
local function fix_window_heights(fix)
	-- Loop over all tabs and all windows within each tab
	for tab = 1, fn.tabpagenr("$") do
		local num_windows = fn.tabpagewinnr(tab, "$")
		-- Skip tabs with only one window
		if num_windows > 1 then
			for win = 1, num_windows do
				fn.settabwinvar(tab, win, "&winfixheight", fix)
			end
		end
	end
end
-- Function to equalize window widths (resizing them to the same width)
local function equalize_window_widths()
	local cur_tab = fn.tabpagenr()
	-- If more than two tab exists, handle tabs separately
	if fn.tabpagenr("$") > 2 then
		local last_accessed_tab = fn.tabpagenr("#")
		cmd("tabdo wincmd =") -- Equalize windows' widths in each tab
		cmd("tabnext " .. last_accessed_tab) -- Return to the last accessed tab
		cmd("tabnext " .. cur_tab) -- Return to the current tab
	else
		cmd("tabdo wincmd =") -- Equalize windows' widths in the current tab
		cmd("tabnext " .. cur_tab) -- Stay on the current tab
	end
end
local toggle_status = true
function _G.toggle_window_resize()
	toggle_status = not toggle_status
end
-- Main function to handle all cases of equalizing window widths and locking heights
function _G.auto_equalize_window_widths()
	if not toggle_status then
		return
	end
	local num_tabs = fn.tabpagenr("$")
	local num_windows = fn.winnr("$")
	-- Case 1: Single window, no tabs, do nothing
	-- flaw: TSContext counts as a window
	if num_windows == 1 and num_tabs == 1 then
		return
	end
	-- Case 2: Multiple windows in a single tab, no tabs
	if num_windows > 1 and num_tabs == 1 then
		-- Lock window heights before resizing
		for win = 1, num_windows do
			fn.setwinvar(win, "&winfixheight", 1)
		end
		cmd("wincmd =") -- Equalize the widths of windows
		-- Unlock window heights after resizing
		for win = 1, num_windows do
			fn.setwinvar(win, "&winfixheight", 0)
		end
		return
	end
	-- Case 3: Multiple tabs, resize windows and adjust heights
	if num_tabs > 1 then
		fix_window_heights(1) -- Lock heights for all windows in all tabs
		equalize_window_widths() -- Equalize window widths
		fix_window_heights(0) -- Unlock heights for all windows
	end
end
