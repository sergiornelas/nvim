-- Toggle true/false
function _G.toggle_boolean()
	local line = vim.api.nvim_get_current_line()
	local new_line = line:gsub("true", "TEMP"):gsub("false", "true"):gsub("TEMP", "false")
	vim.api.nvim_set_current_line(new_line)
end

-- Closes TSContext and Fidget (floating windows) when exit (auto-session)
function _G.close_floating_windows()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= "" then
			vim.api.nvim_win_close(win, false)
		end
	end
end

-- Toggle scratch file
function _G.toggle_file_in_split(filepath)
	local RESIZE_AMOUNT = 6
	_G.file_windows = _G.file_windows or {}
	local current_tab_id = vim.api.nvim_get_current_tabpage()
	_G.file_windows[current_tab_id] = _G.file_windows[current_tab_id] or {}
	local window_id = _G.file_windows[current_tab_id].window_id
	-- If filepath is not present. Useful for auto-session.lua
	if not filepath then
		vim.cmd("normal! mz")
		vim.api.nvim_win_close(window_id, true)
		vim.cmd("windo normal! zz")
		return
	end
	local last_file = _G.file_windows[current_tab_id].last_file or filepath
	if window_id and vim.api.nvim_win_is_valid(window_id) then
		-- Write changes, close window, and return to previous window
		vim.cmd("w")
		-- Store the current file path before closing the window
		_G.file_windows[current_tab_id].last_file = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(window_id))
		vim.cmd("normal! mz")
		vim.api.nvim_win_close(window_id, true)
		vim.cmd("wincmd p")
	else
		-- Open file in new split window, move it to bottom, center cursor, and resize
		local full_filepath = vim.fn.expand(last_file)
		vim.cmd("keepalt split " .. filepath)
		vim.cmd("e" .. full_filepath)
		window_id = vim.api.nvim_get_current_win()
		if vim.fn.getpos("'z")[1] ~= 0 then
			vim.cmd("keepjumps normal! `z")
		end
		vim.cmd("wincmd J")
		vim.cmd("normal! zz")
		vim.cmd("resize +" .. RESIZE_AMOUNT .. " | wincmd p | wincmd p")
	end
	-- Update window ID in file_windows table
	_G.file_windows[current_tab_id].window_id = window_id and vim.api.nvim_win_is_valid(window_id) and window_id or nil
end

-- Equalize windows width (not height) through all tabs when resizing Vim
-- Function to fix or unfix the window heights for all windows in a tab
local function fix_window_heights(fix)
	-- Loop over all tabs and all windows within each tab
	for tab = 1, vim.fn.tabpagenr("$") do
		local num_windows = vim.fn.tabpagewinnr(tab, "$")
		-- Skip tabs with only one window
		if num_windows > 1 then
			for win = 1, num_windows do
				vim.fn.settabwinvar(tab, win, "&winfixheight", fix)
			end
		end
	end
end
-- Function to equalize window widths (resizing them to the same width)
local function equalize_window_widths()
	local cur_tab = vim.fn.tabpagenr()
	-- If more than two tab exists, handle tabs separately
	if vim.fn.tabpagenr("$") > 2 then
		local last_accessed_tab = vim.fn.tabpagenr("#")
		vim.cmd("tabdo wincmd =") -- Equalize windows' widths in each tab
		vim.cmd("tabnext " .. last_accessed_tab) -- Return to the last accessed tab
		vim.cmd("tabnext " .. cur_tab) -- Return to the current tab
	else
		vim.cmd("tabdo wincmd =") -- Equalize windows' widths in the current tab
		vim.cmd("tabnext " .. cur_tab) -- Stay on the current tab
	end
end
-- Main function to handle all cases of equalizing window widths and locking heights
function _G.auto_equalize_window_widths()
	local num_tabs = vim.fn.tabpagenr("$")
	local num_windows = vim.fn.winnr("$")
	-- Case 1: Single window, no tabs, do nothing
	if num_windows == 1 and num_tabs == 1 then
		return
	end
	-- Case 2: Multiple windows in a single tab, no tabs
	if num_windows > 1 and num_tabs == 1 then
		-- Lock window heights before resizing
		for win = 1, num_windows do
			vim.fn.setwinvar(win, "&winfixheight", 1)
		end
		vim.cmd("wincmd =") -- Equalize the widths of windows
		-- Unlock window heights after resizing
		for win = 1, num_windows do
			vim.fn.setwinvar(win, "&winfixheight", 0)
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
