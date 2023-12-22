local api = vim.api
local group = api.nvim_create_augroup("group", { clear = true })
local cmd = api.nvim_create_autocmd

-- Set wrap and spell on specific file types
cmd("FileType", {
	pattern = { "norg", "markdown", "gitcommit" },
	callback = function()
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

-- Closing tab then go back to previous tab
cmd("TabClosed", {
	command = "tabprevious",
})

api.nvim_exec(
	[[
  " Paste command mode
  cnoremap <c-v> <c-r>*

  " Exit terminal
  :tnoremap <esc> <c-\><c-n>

  " Wrap break icon
  set showbreak=↪\ 

  " Stop automatic comment when enter in insert mode
  au BufEnter * set fo-=c fo-=r fo-=o

  " All folds are open
  " set nofoldenable

  " Command prev option
  cnoremap <c-o> <c-p>
  " (vim: not used)

  " close quickfix with escape
  nnoremap <silent> <expr> <esc> &buftype == 'quickfix' ? ":ccl<cr>:lcl<cr>" : '<esc>'
]],
	false
)

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

-- execute <esc>O command
-- vim.api.nvim_exec([[
--   :normal O
-- ]])

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

-- :nmap - Display normal mode maps
-- :imap - Display insert mode maps
-- :vmap - Display visual and select mode maps
-- :smap - Display select mode maps
-- :xmap - Display visual mode maps
-- :cmap - Display command-line mode maps
-- :omap - Display operator pending mode maps

-- Format quickfix
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
