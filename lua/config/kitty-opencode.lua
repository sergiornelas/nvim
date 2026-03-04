local M = {}

-- =========================
-- Config
-- =========================

local KITTY_LS_TTL = 200 -- ms

-- =========================
-- Kitty cache
-- =========================

local kitty_ls_cache = {
	data = nil,
	timestamp = 0,
}

local function get_kitty_ls()
	local now = vim.loop.now()

	if kitty_ls_cache.data and (now - kitty_ls_cache.timestamp < KITTY_LS_TTL) then
		return kitty_ls_cache.data
	end

	local output = vim.fn.system("kitty @ ls")
	if vim.v.shell_error ~= 0 or output == "" then
		return nil
	end

	local ok, decoded = pcall(vim.json.decode, output)
	if not ok then
		return nil
	end

	kitty_ls_cache.data = decoded
	kitty_ls_cache.timestamp = now
	return decoded
end

local function get_current_kitty_tab(data)
	local current_window_id = tonumber(vim.env.KITTY_WINDOW_ID)
	if not current_window_id then
		return nil
	end

	for _, os_window in ipairs(data) do
		for _, tab in ipairs(os_window.tabs or {}) do
			for _, win in ipairs(tab.windows or {}) do
				if win.id == current_window_id then
					return tab
				end
			end
		end
	end

	return nil
end

-- =========================
-- Detection
-- =========================

function M.is_opencode_running_in_tab()
	local data = get_kitty_ls()
	if not data then
		return false
	end

	local tab = get_current_kitty_tab(data)
	if not tab then
		return false
	end

	for _, win in ipairs(tab.windows or {}) do
		for _, proc in ipairs(win.foreground_processes or {}) do
			if proc.cmdline and table.concat(proc.cmdline, " "):match("opencode") then
				return true
			end
		end

		if win.cmdline and table.concat(win.cmdline, " "):match("opencode") then
			return true
		end
	end

	return false
end

-- =========================
-- Actions
-- =========================

function M.tall_layout()
	vim.fn.jobstart({ "kitty", "@", "goto-layout", "tall" }, { detach = true })
end

function M.launch_opencode()
	vim.fn.jobstart({
		"kitty",
		"@",
		"launch",
		"--type=window",
		"--cwd=current",
		"opencode",
		"--port",
	}, { detach = true })
end

-- =========================
-- Notify (throttled)
-- =========================

local notify_state = {}

local function throttled_notify(msg, level, opts)
	local now = vim.loop.now()
	opts = opts or {}

	local key = msg .. (level or "")
	local last = notify_state[key]

	if not last or (now - last > 1500) then
		notify_state[key] = now
		vim.notify(msg, level or vim.log.levels.INFO, opts)
	end
end

-- =========================
-- Public API
-- =========================

--- Execute an expr-action with opencode
--- Must return a string for expr mappings
--- @param fn fun(opencode: table): string
function M.with_opencode_expr(fn)
	local opencode = require("opencode")

	M.tall_layout()

	if not M.is_opencode_running_in_tab() then
		M.launch_opencode()
		return ""
	end

	return fn(opencode)
end

--- Execute an action with opencode if running, otherwise auto-launch it
--- @param fn fun(opencode: table)
function M.with_opencode(fn)
	local opencode = require("opencode")

	M.tall_layout()

	if not M.is_opencode_running_in_tab() then
		M.launch_opencode()
		throttled_notify("Starting OpenCode", vim.log.levels.INFO, { title = "OpenCode" })
		return
	end

	fn(opencode)
end

return M
