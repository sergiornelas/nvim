-- TODO: remove the ticks once kitty ships commit 9ee93ae8c (unreleased as of 0.49.1):
-- "Fix indeterminate progress bar stopping when the window is idle"
-- https://github.com/kovidgoyal/kitty/commit/9ee93ae8c
-- Note: kitty clears progress after 60s without updates, so keep a slow refresh (~30s) if needed
-- https://www.reddit.com/r/neovim/comments/1sacc91/ghostty_progress_bar_in_neovim_012_with/
-- https://www.reddit.com/r/neovim/comments/1rcvliq/comment/o73wdkc/
-- https://github.com/crisecheverria/dotfiles/blob/56929fdb0645cd3e715a72a5fbde410434a9d95b/.config/nvimless/lua/tools/lsp.lua
local M = {}

function M.setup()
	local active_count = 0
	local clear_timer = nil
	local tick_timer = nil
	local current_osc = ""

	local function send_osc(seq)
		vim.api.nvim_ui_send(seq)
	end

	local indeterminate_osc = "\27]9;4;3\27\\"

	local function progress_osc(value)
		if value.percentage then
			return string.format("\27]9;4;1;%d\27\\", value.percentage)
		end
		return indeterminate_osc
	end

	local function cancel_clear_timer()
		if clear_timer then
			clear_timer:stop()
			clear_timer:close()
			clear_timer = nil
		end
	end

	local function tick()
		if current_osc ~= "" then
			send_osc(current_osc)
		end
	end

	local function start_ticking()
		if tick_timer then
			return
		end
		tick_timer = assert(vim.uv.new_timer())
		tick_timer:start(16, 16, vim.schedule_wrap(tick))
	end

	local function stop_ticking()
		if tick_timer then
			tick_timer:stop()
			tick_timer:close()
			tick_timer = nil
		end
	end

	local function clear_progress()
		cancel_clear_timer()
		stop_ticking()
		current_osc = ""
		send_osc("\27]9;4;0\27\\")
	end

	local group = vim.api.nvim_create_augroup("LspProgressBar", { clear = true })

	vim.api.nvim_create_autocmd("VimLeavePre", {
		group = group,
		callback = clear_progress,
	})

	vim.api.nvim_create_autocmd("LspProgress", {
		group = group,
		callback = function(ev)
			local value = ev.data.params.value
			if not value then
				return
			end

			cancel_clear_timer()

			if value.kind == "begin" then
				active_count = active_count + 1
				current_osc = progress_osc(value)
			elseif value.kind == "report" then
				current_osc = progress_osc(value)
			elseif value.kind == "end" then
				active_count = math.max(0, active_count - 1)
				if active_count == 0 then
					current_osc = "\27]9;4;1;100\27\\"
					clear_timer = assert(vim.uv.new_timer())
					clear_timer:start(1500, 0, vim.schedule_wrap(clear_progress))
				end
			end

			-- Only the indeterminate animation needs ticks to keep kitty redrawing
			if current_osc == indeterminate_osc then
				start_ticking()
			else
				stop_ticking()
			end

			send_osc(current_osc)
		end,
	})
end

return M