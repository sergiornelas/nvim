-- LSP progress → terminal progress bar (OSC 9;4)
-- Note: kitty clears progress after 60s without updates, and 5s after reaching 100%
-- (Progress.clear_timeout / finished_clear_timeout in kitty/progress.py)
-- We clear it ourselves after 1.5s because kitty's 5s feels too slow
-- https://www.reddit.com/r/neovim/comments/1sacc91/ghostty_progress_bar_in_neovim_012_with/
-- https://www.reddit.com/r/neovim/comments/1rcvliq/comment/o73wdkc/
-- https://github.com/crisecheverria/dotfiles/blob/56929fdb0645cd3e715a72a5fbde410434a9d95b/.config/nvimless/lua/tools/lsp.lua
local M = {}

function M.setup()
	local active_count = 0
	local clear_timer = nil

	local function send_osc(seq)
		vim.api.nvim_ui_send(seq)
	end

	local function progress_osc(value)
		if value.percentage then
			return string.format("\27]9;4;1;%d\27\\", value.percentage)
		end
		return "\27]9;4;3\27\\" -- indeterminate
	end

	local function cancel_clear_timer()
		if clear_timer then
			clear_timer:stop()
			clear_timer:close()
			clear_timer = nil
		end
	end

	local function clear_progress()
		cancel_clear_timer()
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
				send_osc(progress_osc(value))
			elseif value.kind == "report" then
				send_osc(progress_osc(value))
			elseif value.kind == "end" then
				active_count = math.max(0, active_count - 1)
				if active_count == 0 then
					send_osc("\27]9;4;1;100\27\\")
					clear_timer = assert(vim.uv.new_timer())
					clear_timer:start(1500, 0, vim.schedule_wrap(clear_progress))
				end
			end
		end,
	})
end

return M
