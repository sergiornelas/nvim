local api = vim.api
local group = api.nvim_create_augroup("group", { clear = true })
local cmd = api.nvim_create_autocmd

-- Set specific properties for file types
cmd("FileType", {
	pattern = { "norg", "markdown", "gitcommit" },
	callback = function()
		vim.opt_local.colorcolumn = "80"
		vim.opt_local.textwidth = 80
		vim.opt_local.wrap = true
	end,
})

-- Show yank line highlight
cmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Jump to the last place you’ve visited in a file before exiting
cmd("BufReadPost", { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] })

-- Show cursor line only in active window
cmd({ "InsertLeave", "WinEnter" }, { pattern = "*", command = "set cursorline", group = group })
cmd({ "InsertEnter", "WinLeave" }, { pattern = "*", command = "set nocursorline", group = group })

vim.cmd([[
  " Escape insert mode terminal
  :tnoremap <esc> <c-\><c-n>

  " Wrap break icon
  set showbreak=↪\ 

  " Stop automatic comment when break line in insert mode
  au BufEnter * set fo-=cro

  " Command prev option
  cnoremap <c-o> <c-p>
  " (vim: not used)

  " close quickfix and loclist with escape
  nnoremap <silent> <expr> <esc> &buftype == 'quickfix' ? ":ccl<cr>:lcl<cr>" : '<esc>'

  " macros
  " switch ^[ to \<esc>, switch ^M to \<cr>, switch ^R to \<c-r>
  " email templates:
  let @b='gg00:%s/"/\\"/g\<cr>gg0VGJ0y$`Bvi"P0vaiokkky f'
  " sum columns visual selection
  let @n="mxyGo\<esc>pVGJ0y$:execute('let @t=\<c-r>0')\<cr>dd`x"

  " abbreviations
  " <c-v>+space skip the abbreviation"
  iab @sn sergio.ornelas@nextiva.com
  cab sss SessionSave<cr>
  cab ssd SessionDelete<cr>
]])

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
	local limit = 31
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

-- usefull commands:
-- :wind diffthis - enters diff mode, you can find text differences between two buffers. You need the two buffers & windows opened

-- Symbols listchars
-- opt.listchars = {
-- 	tab = "│ ",
-- 	extends = "→",
-- 	precedes = "←",
-- 	trail = "·",
-- 	nbsp = "␣",
-- 	-- eol = "¬",
-- }
-- opt.list = true

-- Execute command when vim leave
-- autocmd VimLeave * TSContextDisable

-- Execute command when VimEnter and after some miliseconds
-- autocmd VimEnter * call timer_start(10, {-> execute("unmap [%")})

-- Eliminate terminal buffers when enter neovim
-- function! DeleteBufferByExtension(strExt)
--    let s:bufNr = bufnr("$")
--    while s:bufNr > 0
--        if buflisted(s:bufNr)
--            if (matchstr(bufname(s:bufNr), "/".a:strExt."$") == "/".a:strExt )
--               if getbufvar(s:bufNr, '&modified') == 0
--                  execute "bd ".s:bufNr
--               endif
--            endif
--        endif
--        let s:bufNr = s:bufNr-1
--    endwhile
-- endfunction
-- autocmd VimEnter * call timer_start(7, {-> execute("call DeleteBufferByExtension('fish')")})

-- Execute multiple commands after a call timer
-- function CodeRunner()
--   execute 'RunCode'
--   execute 'lua require("colorful-winsep").NvimSeparatorDel()'
-- endfunction
-- nnoremap <leader>sp :Codi <bar> call timer_start(200, CodeRunner())<cr>

-- Auto window resize
-- vim.cmd([[
-- augroup ReduceNoise
--     autocmd!
--     autocmd WinEnter * :call ResizeSplits()
--     autocmd FileType NvimTree set winwidth&
-- augroup END
-- function! ResizeSplits()
--     set winwidth=110
--     wincmd =
-- endfunction
-- ]])

--Execute command for specific filetype
-- if &ft == "lua"
--   set winwidth=110
-- endif

-- Map command for multiple filetypes
-- au FileType javascript,javascriptreact nnoremap...

-- Execute keyboard command
-- :exe "normal \<C-W>\<C-w>"
