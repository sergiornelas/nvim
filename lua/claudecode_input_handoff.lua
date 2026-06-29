-- Carry the unsent draft from an orphaned Claude pane over to its replacement.
--
-- When Neovim restarts, its Claude pane is left orphaned (still running, but with
-- a dead WebSocket link). We can't re-attach it — Claude pins its IDE target at
-- launch and doesn't re-scan for lockfiles live — so we close it and relaunch
-- with --continue. Before closing we scrape whatever was typed-but-unsent in the
-- input box, then paste it straight back into the new session once it is up. The
-- system clipboard is deliberately left untouched.
--
-- It is pure kitty automation: functions take an explicit window id and talk to
-- `kitty @`, holding no state of their own.

local M = {}

-- Scrape the unsent draft from a Claude input box. The box is delimited by two
-- horizontal rules ("─────") with the "❯ " caret on the first inner line:
--
--     ───────────────────── <session title> ──
--     ❯ typed text
--     ─────────────────────────────────────────
--
-- Returns the draft text, or nil if the box is empty / not the Claude prompt.
function M.capture(id)
	if not id then
		return nil
	end
	local screen = vim.fn.system("kitty @ get-text --match id:" .. id)
	if vim.v.shell_error ~= 0 then
		return nil
	end
	-- Claude separates the caret from the text with U+00A0 (non-breaking space),
	-- which Lua's %s does not match; normalize it to a regular space first.
	screen = screen:gsub("\194\160", " ")
	local lines = vim.split(screen, "\n", { plain = true })

	local function is_rule(s)
		return s:match("^%s*─────") ~= nil
	end

	-- Bottom border of the input box: the last horizontal rule on screen. (Below
	-- it sits only the status line, never another rule.)
	local bottom
	for i = #lines, 1, -1 do
		if is_rule(lines[i]) then
			bottom = i
			break
		end
	end
	if not bottom then
		return nil
	end

	-- First input line: the nearest "❯" caret above the bottom border. Anchoring
	-- on the caret instead of a second rule is robust to other "─────" lines on
	-- screen (e.g. in the conversation) and to a tall input whose top border has
	-- scrolled off. Stop at the box's top border: no caret => can't trust it.
	local caret
	for i = bottom - 1, 1, -1 do
		if lines[i]:match("^%s*❯") then
			caret = i
			break
		end
		if is_rule(lines[i]) then
			break
		end
	end
	if not caret then
		return nil
	end

	local parts = {}
	for i = caret, bottom - 1 do
		local after = lines[i]:match("^%s*❯%s?(.*)$")
		if after ~= nil then
			-- First input line: text after the caret.
			table.insert(parts, (after:gsub("%s+$", "")))
		else
			-- Continuation line: drop the 2-column alignment under the caret.
			table.insert(parts, (lines[i]:gsub("%s+$", ""):gsub("^  ", "", 1)))
		end
	end

	local text = table.concat(parts, "\n"):gsub("%s+$", "")
	if text == "" then
		return nil
	end
	return text
end

-- Paste a captured draft into the new pane. Polls until Claude's TUI (its "❯"
-- caret) is up, then sends the text with `--bracketed-paste auto`, which inserts
-- it into the input without submitting (and only once bracketed paste is enabled,
-- so waiting for the caret avoids a premature, dropped paste). Uses `--stdin` so
-- the text is sent verbatim, never interpreted for escapes. Clipboard untouched.
function M.restore(id, text, attempts)
	if not (id and text) then
		return
	end
	attempts = attempts or 0
	local screen = vim.fn.system("kitty @ get-text --match id:" .. id)
	if vim.v.shell_error ~= 0 then
		return -- pane went away
	end
	if screen:find("❯", 1, true) then
		vim.fn.system("kitty @ send-text --match id:" .. id .. " --bracketed-paste auto --stdin", text)
		return
	end
	if attempts < 20 then
		vim.defer_fn(function()
			M.restore(id, text, attempts + 1)
		end, 200)
	end
end

return M
