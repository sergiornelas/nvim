-- Cmdline in a centered floating window, keeping 'cmdheight' untouched.
-- Repositions ui2's cmdline window (vim._core.ui2) while typing and restores
-- it on leave, so messages still render at the bottom.
local api = vim.api

local FLOAT_TYPES = { [":"] = true } -- "/" and "?" stay at the bottom (incsearch)
local BORDER = "single"
local TITLE = " Cmdline "

local ok_ui, ui2 = pcall(require, "vim._core.ui2")
local ok_cmd, ui2_cmdline = pcall(require, "vim._core.ui2.cmdline")
if not (ok_ui and ok_cmd) then
	return
end

local active, saved = false, nil

local function get_win()
	local win = ui2.wins and ui2.wins.cmd
	return (win and api.nvim_win_is_valid(win)) and win or nil
end

local function apply()
	local win = active and get_win()
	if not win then
		return
	end
	if not saved then
		local c = api.nvim_win_get_config(win)
		saved =
			{ relative = c.relative, anchor = c.anchor, row = c.row, col = c.col, width = c.width, border = c.border }
	end
	local cols, lines = vim.o.columns, vim.o.lines
	local width = math.min(math.max(math.floor(cols * 0.45), 30), 60, cols - 2)
	local height = api.nvim_win_get_height(win)
	pcall(api.nvim_win_set_config, win, {
		relative = "editor",
		row = math.max(0, math.floor((lines - height - 2) / 2)),
		col = math.max(0, math.floor((cols - width - 2) / 2)),
		width = width,
		border = BORDER,
		title = TITLE,
		title_pos = "center",
	})
end

local function restore()
	local win = get_win()
	if win and saved then
		pcall(api.nvim_win_set_config, win, saved) -- border "none" also clears the title
	end
	saved = nil
end

-- ui2 looks up its handlers dynamically, so wrapping cmdline_show re-applies the
-- float after ui2 adjusts the window (height, border reset when messages are expanded)
local cmdline_show = ui2_cmdline.cmdline_show
ui2_cmdline.cmdline_show = function(...)
	local r = cmdline_show(...)
	apply()
	return r
end

local group = api.nvim_create_augroup("CmdlineFloat", { clear = true })

api.nvim_create_autocmd("CmdlineEnter", {
	group = group,
	callback = function()
		if vim.v.event.cmdlevel == 1 then
			active = FLOAT_TYPES[vim.v.event.cmdtype] or false
		end
	end,
})

api.nvim_create_autocmd("CmdlineLeave", {
	group = group,
	callback = function()
		if vim.v.event.cmdlevel == 1 then
			active = false
			restore()
		end
	end,
})

api.nvim_create_autocmd("VimResized", {
	group = group,
	callback = function()
		vim.schedule(apply)
	end,
})
