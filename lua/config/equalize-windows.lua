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
    " one window, no TSContext/Fidget, no tabs  
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
