-- Notes file in a centered float over a dimmed backdrop.
-- <leader>n opens it (or focuses it), "q" or moving to a regular window closes it,
-- pickers close it on show and markdown_headings_index() moves it to a new tab.
local api = vim.api
local fn = vim.fn

local SIZE = 0.8 -- relative to the editor
local BLEND = 50 -- backdrop opacity
local ZINDEX = 40 -- below default float zindex (50) so popups (gitsigns, hover) show on top
local WO = {
	cursorline = true,
	colorcolumn = "80",
	winbar = " %{%v:lua.require'nvim-navic'.get_location()%}",
}

local group = api.nvim_create_augroup("FileInFloat", { clear = true })
local state = {} -- { win, buf }

local function cleanup()
	pcall(vim.keymap.del, "n", "q", { buffer = state.buf })
	api.nvim_clear_autocmds({ group = group })
	state = {}
end

local function backdrop_config()
	return { relative = "editor", row = 0, col = 0, width = vim.o.columns, height = vim.o.lines }
end

local function float_config()
	local width = math.floor(vim.o.columns * SIZE)
	local height = math.floor(vim.o.lines * SIZE)
	return {
		relative = "editor",
		width = width,
		height = height,
		row = math.floor((vim.o.lines - height) / 2),
		col = math.floor((vim.o.columns - width) / 2),
	}
end

-- Opens the backdrop + float and enters the float; cleanup() runs when it closes
local function open_float(buf, title)
	local backdrop_buf = api.nvim_create_buf(false, true)
	vim.bo[backdrop_buf].bufhidden = "wipe"
	local backdrop = api.nvim_open_win(
		backdrop_buf,
		false,
		vim.tbl_extend("force", backdrop_config(), {
			style = "minimal",
			border = "none",
			focusable = false,
			noautocmd = true,
			zindex = ZINDEX - 1,
		})
	)
	vim.wo[backdrop][0].winhighlight = "Normal:ScratchBackdrop"
	vim.wo[backdrop][0].winblend = BLEND
	-- border comes from 'winborder'
	local win = api.nvim_open_win(
		buf,
		true,
		vim.tbl_extend("force", float_config(), { title = title, title_pos = "center", zindex = ZINDEX })
	)
	for k, v in pairs(WO) do
		vim.wo[win][0][k] = v
	end
	api.nvim_create_autocmd("VimResized", {
		group = group,
		callback = function()
			pcall(api.nvim_win_set_config, backdrop, backdrop_config())
			pcall(api.nvim_win_set_config, win, float_config())
		end,
	})
	api.nvim_create_autocmd("WinClosed", {
		group = group,
		pattern = tostring(win),
		once = true,
		callback = function()
			pcall(api.nvim_win_close, backdrop, true)
			cleanup()
		end,
	})
	-- Close when moving to a regular window (<c-w>p, mouse, other tab);
	-- floats (spelling picker, entered hover) keep it open
	api.nvim_create_autocmd("WinEnter", {
		group = group,
		nested = true, -- so closing triggers WinClosed → cleanup()
		callback = function()
			if api.nvim_win_get_config(0).relative == "" then
				pcall(api.nvim_win_close, win, true)
			end
		end,
	})
	-- <c-w>H/J/K/L turn the float into a regular split (same window, no WinClosed):
	-- drop the backdrop and float-only options and stop tracking it
	api.nvim_create_autocmd("WinResized", {
		group = group,
		callback = function()
			if api.nvim_win_is_valid(win) and api.nvim_win_get_config(win).relative == "" then
				pcall(api.nvim_win_close, backdrop, true)
				api.nvim_win_call(win, function()
					vim.cmd("setlocal colorcolumn< winbar<")
				end)
				cleanup()
			end
		end,
	})
	return win
end

function _G.close_file_in_float()
	if not (state.win and api.nvim_win_is_valid(state.win)) then
		return false
	end
	pcall(api.nvim_win_close, state.win, true) -- WinClosed → cleanup()
	return true
end

-- Reopens the float as a regular window in a new tab (like <c-w>T), no longer tracked
function _G.promote_file_in_float_to_tab()
	if not (state.win and state.win == api.nvim_get_current_win()) then
		return false
	end
	local buf, cursor = state.buf, api.nvim_win_get_cursor(state.win)
	_G.close_file_in_float()
	vim.cmd("tab sbuffer " .. buf)
	api.nvim_win_set_cursor(0, cursor)
	return true
end

function _G.open_file_in_float(filepath)
	-- Already open (it closes on entering a regular window, so focus is in another float)
	if state.win and api.nvim_win_is_valid(state.win) then
		api.nvim_set_current_win(state.win)
		return
	end
	-- Defined here because `:colorscheme` clears user highlight groups
	api.nvim_set_hl(0, "ScratchBackdrop", { bg = "#000000", default = true })
	local file = fn.expand(filepath)
	local buf = fn.bufadd(file)
	fn.bufload(buf)
	local title = " " .. fn.fnamemodify(file, ":t") .. " "
	state = { win = open_float(buf, title), buf = buf }
	vim.keymap.set("n", "q", _G.close_file_in_float, { buffer = buf, nowait = true, silent = true })
end
