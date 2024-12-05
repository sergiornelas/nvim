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
vim.cmd([[
  function Windows_Fix_Height(status)
    " tabpagenr('$') = number of total tabs
    for t in range(1, tabpagenr('$'))
      " number of windows in tab t
      if tabpagewinnr(t, '$') == 1
        continue
      endif
      for w in range(1, tabpagewinnr(t, '$'))
        call settabwinvar(t, w, '&winfixheight', a:status)
      endfor
    endfor
  endfunction

  function Equalize_Windows()
    let cur_tab = tabpagenr()
    if tabpagenr('$') > 2
      let last_accessed_tab = tabpagenr('#')
      tabdo exe 'wincmd ='
      execute 'tabnext ' . last_accessed_tab
      execute 'tabnext ' . cur_tab
    else
      tabdo exe 'wincmd ='
      execute 'tabnext ' . cur_tab
    endif
  endfunction

  function Auto_Equalize_Width_All_Windows()
    " one window, no floating windows, no tabs 
    if winnr('$') == 1 && tabpagenr('$') == 1
      return
    endif

    " more than one window, no tabs  
    if winnr('$') > 1 && tabpagenr('$') == 1
      for w in range(1, winnr('$'))
        call setwinvar(w, '&winfixheight', 1)
      endfor
      exe 'wincmd ='
      for w in range(1, winnr('$'))
        call setwinvar(w, '&winfixheight', 0)
      endfor
      return
    endif

    " more than one tab  
    if tabpagenr('$') > 1
      call Windows_Fix_Height(1)
      call Equalize_Windows()
      call Windows_Fix_Height(0)
    endif
  endfunction
  au VimResized * call Auto_Equalize_Width_All_Windows()
]])
