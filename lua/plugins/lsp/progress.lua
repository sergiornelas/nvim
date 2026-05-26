local M = {}

function M.setup()
	local active_count = 0
	local clear_timer = nil
	local tick_timer = nil
	local current_osc = ""

	local function send_osc(seq)
		vim.api.nvim_ui_send(seq)
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
		if clear_timer then
			clear_timer:stop()
			clear_timer = nil
		end
		stop_ticking()
		current_osc = ""
		send_osc("\27]9;4;0\27\\")
	end

	vim.api.nvim_create_autocmd("VimLeavePre", {
		callback = clear_progress,
	})

	vim.api.nvim_create_autocmd("LspProgress", {
		callback = function(ev)
			local value = ev.data.params.value
			if not value then
				return
			end

			if clear_timer then
				clear_timer:stop()
				clear_timer = nil
			end

			if value.kind == "begin" then
				if active_count == 0 then
					start_ticking()
				end
				active_count = active_count + 1
				if value.percentage then
					current_osc = string.format("\27]9;4;1;%d\27\\", value.percentage)
				else
					current_osc = "\27]9;4;3\27\\"
				end
			elseif value.kind == "report" then
				if value.percentage then
					current_osc = string.format("\27]9;4;1;%d\27\\", value.percentage)
				else
					current_osc = "\27]9;4;3\27\\"
				end
			elseif value.kind == "end" then
				active_count = math.max(0, active_count - 1)
				if active_count == 0 then
					current_osc = "\27]9;4;1;100\27\\"
					clear_timer = assert(vim.uv.new_timer())
					clear_timer:start(1500, 0, vim.schedule_wrap(clear_progress))
				end
			end

			send_osc(current_osc)
		end,
	})
end

return M
