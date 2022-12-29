vim.g.calendar_google_calendar = 1
vim.g.calendar_google_task = 1
vim.g.calendar_first_day = "monday"
vim.g.calendar_skip_task_clear_completed_confirm = 1
vim.g.calendar_task_width = 100
vim.g.calendar_task_delete = 0

vim.api.nvim_exec(
	[[
   source ~/.cache/calendar.vim/credentials.vim
   augroup calendar-mappings
    autocmd!
    autocmd FileType calendar nmap <buffer> V <Plug>(calendar_visual)
    autocmd FileType calendar nmap <buffer> v <Plug>(calendar_visual_line)
    autocmd FileType calendar nmap <buffer> <cr> <Plug>(calendar_task)
    autocmd FileType calendar nmap <buffer> e <Plug>(calendar_event)
    autocmd FileType calendar nmap <buffer> <s-l> <Plug>(calendar_view_left)
    autocmd FileType calendar nmap <buffer> <s-h> <Plug>(calendar_view_right)
    autocmd FileType calendar nmap <buffer> <c-z> <Plug>(calendar_task_delete)
    autocmd FileType calendar nmap <buffer> <leader>u <Plug>(calendar_exit)
   augroup END
  ]],
	false
)
