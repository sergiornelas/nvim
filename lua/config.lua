vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_transparency = 0.8
vim.g.neovide_refresh_rate = 60
vim.g.neovide_transparency = 0.85

-- Highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])

vim.opt.shortmess:append("c")

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]]) -- TODO: this doesn't seem to work
vim.cmd("set nofoldenable") --helps with everything fold

-- I want to defer lsp by a bit, and some other utilities
local M = {}
M.packer_lazy_load = function(plugin, timer)
	if plugin then
		timer = timer or 0
		vim.defer_fn(function()
			require("packer").loader(plugin)
		end, timer)
	end
end
return M

-- Using autocmd and CursorMoved/CursorMovedI events, zz
-- is applied to every keystroke that would change the cursor position.
-- Minorly optimized by only applying zz to vertical line movement.
-- Will update to lua once autocmd is natively supported, vimscript is
-- currently more performant.

-- vim.api.nvim_exec(
--   [[
--     :function StayCenteredI()
--     :  let line = line(".")
--     :  if line != get(b:, 'last_line', 0)
--     :    let col = getcurpos()[4]
--     :    normal! zz
--     :    call cursor(line, col)
--     :    let b:last_line = line
--     :  endif
--     :endfunction
--     :function StayCentered()
--     :  let line = line(".")
--     :  if line != get(b:, 'last_line', 0)
--     :    normal! zz
--     :    let b:last_line = line
--     :  endif
--     :endfunction
--     augroup StayCentered
--       autocmd!
--       autocmd CursorMovedI * :call StayCenteredI()
--       autocmd CursorMoved * :call StayCentered()
--     augroup END
--   ]], true
-- )

-- FORMAT ON SAVE ====================
--vim.api.nvim_exec([[
--augroup FormatAutogroup
--autocmd!
--autocmd BufWritePost *.js,*.rs,*.lua FormatWrite
--augroup END
--]], true)

--vim.api.nvim_exec([[
--function! AddLastLine()
--if getline('$') !~ "^$"
--call append(line('$'), '')
--endif
--endfunction
--autocmd BufWritePre * call AddLastLine()
--]])

--vim.api.nvim_exec ([[
--  autocmd BufWritePre * if (getline('$') !~ "^\s*$") | call append(line('$'), "") | endif
--]], true)
