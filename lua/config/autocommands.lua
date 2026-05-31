--- @param mode string
--- @param key string
--- @param command string
local function map(mode, key, command)
	vim.api.nvim_buf_set_keymap(0, mode, key, command, { noremap = true, silent = true })
end
local autocmd = vim.api.nvim_create_autocmd
local create_group = vim.api.nvim_create_augroup

-- Set group colors
create_group("MyColors", { clear = true })
autocmd("ColorScheme", {
	group = "MyColors",
	pattern = "*",
	callback = function()
		local highlights = {
			{ "BlinkCmpDoc", { bg = "#151413", fg = "#efe4ca" } },
			{ "BlinkCmpLabel", { fg = "#efe4ca" } },
			{ "BlinkCmpLabelMatch", { fg = "#70afb0" } },
			{ "BlinkCmpMenu", { bg = "#1f1e1c" } },
			{ "BlinkCmpMenuSelection", { bg = "#4b4a48" } },
			{ "Comment", { fg = "#928374", italic = true } },
			{ "ContextVt", { fg = "#716a56", italic = true } },
			{ "CursorLine", { bg = "#25424D" } },
			{ "CursorLineNr", { bg = "#0f0e0e", fg = "#afacac" } },
			{ "GitSignsAddInline", { fg = "#151413", bg = "#CFC8B0" } },
			{ "GitSignsAddPreview", { fg = "#efe4ca", bg = "#33590D" } },
			{ "GitSignsChangeInline", { fg = "#151413", bg = "#CFC8B0" } },
			{ "GitSignsCurrentLineBlame", { fg = "#9d9681", bg = "#403e3e" } },
			{ "GitSignsDeleteInline", { fg = "#151413", bg = "#CFC8B0" } },
			{ "GitSignsDeletePreview", { fg = "#efe4ca", bg = "#590D0D" } },
			{ "HlSearchLensNear", { fg = "#ebdbb2", bg = "#4f0000" } },
			{ "HlSearchNear", { link = "None" } },
			{ "LineNr", { fg = "#807B7B" } },
			{ "LspInlayHint", { fg = "#74716A", italic = true } },
			{ "LspReferenceRead", { fg = "#DACBA5", bg = "#403e3e" } },
			{ "LspReferenceText", { fg = "#DACBA5", bg = "#403e3e" } },
			{ "LspReferenceWrite", { fg = "#DACBA5", bg = "#403e3e" } },
			{ "MiniIndentscopeSymbol", { fg = "#DACBA5" } },
			{ "MsgArea", { fg = "#DACBA5" } },
			{ "SnacksIndent", { fg = "#525050" } },
			{ "TreesitterContext", { bg = "#34312F" } },
			{ "TreesitterContextBottom", { underline = true, sp = "#887F68" } },
			{ "TreesitterContextLineNumber", { fg = "#807B7B" } },
			{ "Visual", { bg = "#52524e" } },
			{ "VisualNonText", { fg = "#9d9681", bg = "#52524e" } },
			{ "WinBar", { bg = "#151413", bold = true } },
			{ "WinBarNC", { bg = "#151413", bold = true } },
		}
		for _, highlight in ipairs(highlights) do
			vim.api.nvim_set_hl(0, highlight[1], highlight[2])
		end
	end,
})

-- Set specific options/keymaps for markdown files
autocmd("FileType", {
	pattern = { "markdown" },
	callback = function()
		-- manual setting: set cc=80
		vim.opt_local.colorcolumn = "80"
		vim.opt_local.textwidth = 80
		map("n", "y<leader>", "^f:llyE") -- yank secret password
		map("i", "<c-g><c-space>", "- [ ] ") -- create a checkbox current line
		map("i", "<c-g><c-g>", "<esc>o- [ ] ") -- create a checkbox below
		map("i", "<c-g><c-t>", "<esc>O- [ ] ") -- create a checkbox above
		map("n", "gf", "<cmd>normal! $hgf<cr>") -- go to file under cursor
		map("n", "<leader><esc>", "Gmxo<esc>`xgwj") -- break line down and format the lines below
		map("i", "<c-z>", "<c-g>u<Esc>[s1z=`]a<c-g>u") -- fix last spell
		map("n", "<leader>j", "i<c-g>u<Esc>]s1z=`]a<c-g>u<esc>") -- fix next spell
		map("n", "<leader>k", "i<c-g>u<Esc>[s1z=`]a<c-g>u<esc>") -- fix prev spell
	end,
})

-- Close quickfix and loclist with escape and q
autocmd("FileType", {
	pattern = { "qf" },
	callback = function()
		map("n", "<esc>", "<cmd>ccl<cr><cmd>lcl<cr>")
		map("n", "q", "<cmd>ccl<cr><cmd>lcl<cr>")
	end,
})

-- Stop automatic comment when break line in insert mode
autocmd("BufEnter", {
	pattern = "*",
	command = "set fo-=cro",
})

-- Show cursor line only in active window
autocmd({ "InsertLeave", "WinEnter" }, { pattern = "*", command = "set cursorline" })
autocmd({ "InsertEnter", "WinLeave" }, { pattern = "*", command = "set nocursorline" })

-- Jump to the last place you've visited in a file before exiting
local function augroup(name)
	return create_group("lazyvim_" .. name, { clear = true })
end
autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
			return
		end
		vim.b[buf].lazyvim_last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Trigger equalize windows function
autocmd("VimResized", {
	group = create_group("resize_splits", { clear = true }),
	callback = function()
		auto_equalize_window_widths()
	end,
})

-- Reference commands ========================
-- Execute command when VimEnter and after some miliseconds
-- autocmd VimEnter * call timer_start(10, {-> execute("unmap [%")})

-- Execute multiple commands after a call timer
-- function CodeRunner()
--   execute 'RunCode'
--   execute 'lua require("colorful-winsep").NvimSeparatorDel()'
-- endfunction
-- nnoremap <leader>sp :Codi <bar> call timer_start(200, CodeRunner())<cr>

-- enters diff mode, you can find text differences between two buffers. You need the two buffers & windows opened
-- :wind diffthis
