local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	open_mapping = [[<c-t>]],
	direction = "vertical",
	size = vim.o.columns * 1,
	insert_mappings = true, --disables toggle term when you're on insert mode
	shading_factor = 3,
	-- on_open = fun(t: Terminal)
	-- persist_size = false,
	-- float_opts = {
	-- 	border = "single",
	-- 	width = 100,
	-- 	height = 40,
	-- },
	-- size = 81,
	-- size = vim.o.columns * 0.4,
})

function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
	-- vim.api.nvim_buf_set_keymap(0, "t", "<C-v>", [[<C-\><C-n><C-W>ja<c-h>]], opts)
	-- vim.api.nvim_buf_set_keymap(0, "t", "<C-o>", [[<C-\><C-n><C-W>ka<c-h>]], opts)
	-- vim.api.nvim_buf_set_keymap(0, "n", "<C-v>", [[<C-\><C-n><C-W>j]], opts)
	-- vim.api.nvim_buf_set_keymap(0, "n", "<C-o>", [[<C-\><C-n><C-W>k]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-v>", [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-o>", [[<C-\><C-n><C-W>k]], opts)
	vim.api.nvim_buf_set_keymap(0, "n", "<C-v>", [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, "n", "<C-o>", [[<C-\><C-n><C-W>k]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- vim.cmd([[
--   autocmd TermEnter term://*toggleterm#*
--   \ tnoremap <silent><c-t> <Cmd>exe v:count1 . "5ToggleTerm"<CR>
--   nnoremap <silent><c-t> <Cmd>exe v:count1 . "5ToggleTerm"<CR>
--   autocmd TermEnter term://*toggleterm#*
--   \ tnoremap <silent><c-g> <Cmd>exe v:count1 . "ToggleTerm"<CR>
--   nnoremap <silent><c-g> <Cmd>exe v:count1 . "ToggleTerm"<CR>
-- ]])

-- local Terminal = require("toggleterm.terminal").Terminal
-- local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
-- function _LAZYGIT_TOGGLE()
-- 	lazygit:toggle()
-- end
-- vim.api.nvim_set_keymap("n", "<c-w><c-g>", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { noremap = true, silent = true })
