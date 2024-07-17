-- Closes TSContext and Fidget (floating windows) when exit (auto-session)
function _G.close_floating_windows()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= "" then
			vim.api.nvim_win_close(win, false)
		end
	end
end

-- TODO: Persistent last_file after closing neovim
-- Toggle scratch file
function _G.toggle_file_in_split(filepath)
	local RESIZE_AMOUNT = 6
	_G.file_windows = _G.file_windows or {}

	local current_tab_id = vim.api.nvim_get_current_tabpage()

	_G.file_windows[current_tab_id] = _G.file_windows[current_tab_id] or {}
	local window_id = _G.file_windows[current_tab_id].window_id
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
		vim.cmd("normal! `z")
		vim.cmd("wincmd J")

		vim.cmd("normal! zz")
		vim.cmd("resize +" .. RESIZE_AMOUNT .. " | wincmd p | wincmd p")
	end

	-- Update window ID in file_windows table
	_G.file_windows[current_tab_id].window_id = window_id and vim.api.nvim_win_is_valid(window_id) and window_id or nil
end

-- Pretty quickfix
local fn = vim.fn
function _G.qftf(info)
	local items
	local ret = {}
	if info.quickfix == 1 then
		items = fn.getqflist({ id = info.id, items = 0 }).items
	else
		items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
	end
	local limit = 55 -- file path limit
	local fnameFmt1, fnameFmt2 = "%-" .. limit .. "s", "…%." .. (limit - 1) .. "s"
	local validFmt = "%s │%5d:%-3d│%s %s"
	for i = info.start_idx, info.end_idx do
		local e = items[i]
		local fname = ""
		local str
		if e.valid == 1 then
			if e.bufnr > 0 then
				fname = fn.bufname(e.bufnr)
				if fname == "" then
					fname = "[No Name]"
				else
					fname = fname:gsub("^" .. vim.env.HOME, "~")
				end
				-- char in fname may occur more than 1 width, ignore this issue in order to keep performance
				if #fname <= limit then
					fname = fnameFmt1:format(fname)
				else
					fname = fnameFmt2:format(fname:sub(1 - limit))
				end
			end
			local lnum = e.lnum > 99999 and -1 or e.lnum
			local col = e.col > 999 and -1 or e.col
			local qtype = e.type == "" and "" or " " .. e.type:sub(1, 1):upper()
			str = validFmt:format(fname, lnum, col, qtype, e.text)
		else
			str = e.text
		end
		table.insert(ret, str)
	end
	return ret
end
vim.o.qftf = "{info -> v:lua._G.qftf(info)}"

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
