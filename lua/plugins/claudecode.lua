-- TODO: If user is in a different tab than claude code running, focusing in the window
-- with neovim session should be ignored. Only triggers that if we are currently in the same tab
-- where the claude code is running

local kitty_pane_id = nil
local nvim_pane_id = tonumber(vim.fn.getenv("KITTY_WINDOW_ID"))
local startup_check_done = false

-- Decode `kitty @ ls` once into a Lua table, or nil if unavailable / not in Kitty.
local function list_os_windows()
	local output = vim.fn.system("kitty @ ls 2>/dev/null")
	if vim.v.shell_error ~= 0 then
		return nil
	end
	local ok, os_windows = pcall(vim.json.decode, output)
	if not ok or type(os_windows) ~= "table" then
		return nil
	end
	return os_windows
end

-- True only if a Kitty *window* (not a tab/os-window) with this id exists.
-- Grepping the raw JSON gave false positives: "id": 1 matched "id": 18, and it
-- also matched tab/os-window ids, so we walk the decoded window list instead.
local function pane_exists(id)
	if not id then
		return false
	end
	local os_windows = list_os_windows()
	if not os_windows then
		return false
	end
	for _, os_win in ipairs(os_windows) do
		for _, tab in ipairs(os_win.tabs or {}) do
			for _, win in ipairs(tab.windows or {}) do
				if win.id == id then
					return true
				end
			end
		end
	end
	return false
end

-- Find an orphaned Claude window (marked with the user var claude=1) in the same
-- Kitty tab as Neovim. We don't match by title: it belongs to Claude Code, which
-- sets it to the session name (/rename) or the auto-generated topic.
-- Returns the window id, or nil if none exists / not in Kitty.
local function find_orphan_claude_in_nvim_tab()
	if not nvim_pane_id then
		return nil
	end
	local os_windows = list_os_windows()
	if not os_windows then
		return nil
	end
	for _, os_win in ipairs(os_windows) do
		for _, tab in ipairs(os_win.tabs or {}) do
			local has_nvim, claude_id = false, nil
			for _, win in ipairs(tab.windows or {}) do
				if win.id == nvim_pane_id then
					has_nvim = true
				end
				if win.user_vars and win.user_vars.claude == "1" then
					claude_id = win.id
				end
			end
			if has_nvim and claude_id then
				return claude_id
			end
		end
	end
	return nil
end

-- Layout of the Kitty tab that holds the window with this id, or nil if not found.
local function pane_layout(id)
	local os_windows = list_os_windows()
	if not (id and os_windows) then
		return nil
	end
	for _, os_win in ipairs(os_windows) do
		for _, tab in ipairs(os_win.tabs or {}) do
			for _, win in ipairs(tab.windows or {}) do
				if win.id == id then
					return tab.layout
				end
			end
		end
	end
	return nil
end

-- Full size of the Kitty window when showing a hidden Claude pane; it's never shrunk
-- back. Same script that kitty_mod+space uses (kitty/toggle_term.py). detach: do not
-- wait for yabai.
local fullscreen_zoom_script = vim.fn.expand("~/.config/kitty/fullscreen_zoom.sh")
local function fullscreen_zoom()
	vim.fn.jobstart({ fullscreen_zoom_script }, { detach = true })
end

local function focus_pane()
	if kitty_pane_id then
		vim.fn.system("kitty @ focus-window --match id:" .. kitty_pane_id)
	end
end

local function close_pane()
	if kitty_pane_id then
		vim.fn.system("kitty @ close-window --match id:" .. kitty_pane_id)
		kitty_pane_id = nil
	end
end

-- Captures the orphan's unsent draft and pastes it back into the new session.
local input_handoff = require("claudecode_input_handoff")

local function launch_pane(cmd_string, env_table)
	local restored_input = nil
	if not startup_check_done then
		startup_check_done = true
		local orphan_id = find_orphan_claude_in_nvim_tab()
		if orphan_id then
			-- An orphaned Claude (its Neovim died/restarted) CANNOT be re-linked.
			-- The process stays alive and applies changes, but it loses the IDE link
			-- (the WebSocket to Neovim), so it stops sending diffs to Neovim. And `/ide`
			-- does NOT recover it: Claude fixes its target IDE at STARTUP (via the
			-- CLAUDE_CODE_SSE_PORT env var the plugin injects) and does not re-scan the
			-- lockfiles in ~/.claude/ide live. Verified empirically: a fresh `claude`
			-- does find Neovim via `/ide`, but the orphan answers "No available IDEs
			-- detected" even when a new lockfile for the current Neovim exists. Hence
			-- the workaround: rescue its unsent draft, close the orphan, and relaunch
			-- with --continue/--resume (recovers the conversation history, though not
			-- any execution that was in flight).
			restored_input = input_handoff.capture(orphan_id)
			vim.fn.system("kitty @ close-window --match id:" .. orphan_id)
			if not cmd_string:match("%-%-continue") and not cmd_string:match("%-%-resume") then
				cmd_string = cmd_string .. " --continue"
			end
		end
	end
	local env_args = ""
	for k, v in pairs(env_table or {}) do
		env_args = env_args .. "--env " .. k .. "=" .. vim.fn.shellescape(v) .. " "
	end
	local cwd = vim.fn.getcwd()
	fullscreen_zoom()
	vim.fn.system("kitty @ goto-layout tall")
	-- --add-to-session=.: the pane joins Neovim's kitty session. With an explicit
	-- --cwd kitty does not do this on its own, so goto_session would not remember the
	-- pane and would always focus the first one when returning to the session.
	local result = vim.fn.system(
		"kitty @ launch --type=window --location=vsplit --var=claude=1 --copy-env --add-to-session=. --cwd="
			.. vim.fn.shellescape(cwd)
			.. " "
			.. env_args
			.. cmd_string
	)
	kitty_pane_id = tonumber(vim.trim(result))

	if restored_input and kitty_pane_id then
		input_handoff.restore(kitty_pane_id, restored_input)
	end
end

local augroup = vim.api.nvim_create_augroup("ClaudeCodeKitty", { clear = true })

-- When a diff opens: bring focus to Neovim and set up hunk navigation.
-- ClaudeCodeDiffOpened always fires and provides diff_window, so the keymaps go on
-- the right buffer without guessing by the "(proposed)" name.
vim.api.nvim_create_autocmd("User", {
	group = augroup,
	pattern = "ClaudeCodeDiffOpened",
	callback = function(ev)
		if nvim_pane_id then
			vim.fn.system("kitty @ focus-window --match id:" .. nvim_pane_id)
			-- git diff in full screen:
			-- vim.fn.system("kitty @ goto-layout stack")
		end
		local diff_window = ev.data and ev.data.diff_window
		if not (diff_window and vim.api.nvim_win_is_valid(diff_window)) then
			return
		end
		local opts = { buffer = vim.api.nvim_win_get_buf(diff_window) }
		vim.keymap.set("n", "<c-j>", function()
			vim.cmd.normal({ "]c", bang = true })
		end, opts)
		vim.keymap.set("n", "<c-k>", function()
			vim.cmd.normal({ "[c", bang = true })
		end, opts)
	end,
})

-- Focus returns to the Claude pane when the diff closes (accept/deny/etc.).
-- ClaudeCodeDiffClosed always fires, however the diff is closed, so it is more
-- reliable than guessing by the "(proposed)" buffer name in BufWinLeave/TabClosed.
vim.api.nvim_create_autocmd("User", {
	group = augroup,
	pattern = "ClaudeCodeDiffClosed",
	callback = focus_pane,
})

-- After each send (go/gl/gll): focus the Claude pane.
vim.api.nvim_create_autocmd("User", {
	group = augroup,
	pattern = "ClaudeCodeSendComplete",
	callback = function()
		if not pane_exists(kitty_pane_id) then
			return
		end
		focus_pane()
	end,
})

return {
	-- In a future, check this:
	-- https://github.com/ThorstenRhau/brygga.nvim
	"coder/claudecode.nvim",
	cmd = { "ClaudeCode", "ClaudeCodeAdd", "ClaudeCodeSend", "ClaudeCodeTreeAdd", "ClaudeCodeDiffDeny" },
	enabled = true,
	opts = {
		-- Hides the plugin's INFO messages (e.g. "keepalive timeout ... closing connection",
		-- harmless: Claude Code reconnects on its own). WARN/ERROR still show up.
		log_level = "warn",
		terminal = {
			provider = {
				is_available = function()
					return true
				end,

				setup = function() end,

				open = function(cmd_string, env_table)
					if pane_exists(kitty_pane_id) then
						-- In stack Claude is hidden behind Neovim; in tall it's already shown.
						if pane_layout(kitty_pane_id) == "stack" then
							fullscreen_zoom()
						end
						vim.fn.system("kitty @ goto-layout tall")
						focus_pane()
					else
						launch_pane(cmd_string, env_table)
					end
				end,

				close = close_pane,

				simple_toggle = function(cmd_string, env_table)
					if pane_exists(kitty_pane_id) then
						close_pane()
					else
						launch_pane(cmd_string, env_table)
					end
				end,

				focus_toggle = function(cmd_string, env_table)
					if pane_exists(kitty_pane_id) then
						focus_pane()
					else
						launch_pane(cmd_string, env_table)
					end
				end,

				get_active_bufnr = function()
					return nil
				end,
			},
		},
		-- Diff Integration
		diff_opts = {
			layout = "vertical", -- "vertical", "horizontal" or "unified"
			auto_resize_terminal = false, -- kitty manages the pane width, not Neovim
			open_in_new_tab = true,
			keep_terminal_focus = false, -- If true, moves focus back to terminal after diff opens. [Doesn't work with my current custom provider].
			hide_terminal_in_new_tab = false,
			-- on_new_file_reject = "keep_empty", -- "keep_empty" or "close_window"

			-- Legacy aliases (still supported):
			-- vertical_split = true,
			-- open_in_current_tab = true,
		},
	},
	config = function(_, opts)
		require("claudecode").setup(opts)
		require("claudecode.selection").send_selection_update = function() end
	end,
	keys = {
		{ "g]", "<cmd>ClaudeCode --resume<cr>" }, -- (vim: :tselect on the tag under the cursor)
		{ "g[", "<cmd>ClaudeCode --continue<cr>" },
		{ "go", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" }, -- (vim: cursor to byte N in the buffer)
		{ "gl", "<cmd>ClaudeCodeSend<cr>", mode = "v" },
		{
			"gll",
			function()
				local mode = vim.fn.mode()
				if mode == "v" or mode == "V" then
					vim.cmd("ClaudeCodeSend")
				else
					vim.cmd("normal! V")
					vim.cmd("ClaudeCodeSend")
				end
			end,
			desc = "Send selection or current line to Claude",
		},
		{
			"gll",
			"<cmd>ClaudeCodeTreeAdd<cr>",
			desc = "Add file",
			ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
		},
		{ "gq", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" }, -- (vim: format Nmove text)
		{
			"g.",
			function()
				local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
				if #diagnostics == 0 then
					vim.notify("No diagnostics on current line", vim.log.levels.INFO)
					return
				end
				local lines = {}
				for _, d in ipairs(diagnostics) do
					table.insert(lines, d.message)
				end
				local filename = vim.fn.expand("%")
				local lnum = vim.fn.line(".")
				local text = "@" .. filename .. "#L" .. lnum .. "\n" .. table.concat(lines, "\n")

				local function send_text()
					-- In the deferred branch the pane may not have launched yet; without an id,
					-- "kitty @ send-text --match id:" would be malformed, so we bail out.
					if not kitty_pane_id then
						return
					end
					vim.fn.system("kitty @ send-text --match id:" .. kitty_pane_id .. " " .. vim.fn.shellescape(text))
					focus_pane()
				end

				if pane_exists(kitty_pane_id) then
					send_text()
				else
					kitty_pane_id = nil
					vim.cmd("ClaudeCode")
					vim.defer_fn(send_text, 1000)
				end
			end,
		},
	},
}
