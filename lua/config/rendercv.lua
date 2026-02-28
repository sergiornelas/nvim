local DEBOUNCE_MS = 400
local OUTPUT_DIR = "rendercv_output"
local uv = vim.uv or vim.loop
local render_timer = nil

-- ─────────────────────────────────────────────────────────────
-- Helpers
-- ─────────────────────────────────────────────────────────────

local PDF_BY_PROFILE = {
	Frontend = OUTPUT_DIR .. "/SergioOrnelas-Frontend-Resume.pdf",
	Backend = OUTPUT_DIR .. "/SergioOrnelas-Backend-Resume.pdf",
	Fullstack = OUTPUT_DIR .. "/SergioOrnelas-Fullstack-Resume.pdf",
}

local function get_pdf_name(cv_path)
	for key, pdf in pairs(PDF_BY_PROFILE) do
		if cv_path:match(key) then
			return pdf
		end
	end
	return OUTPUT_DIR .. "/SergioOrnelas-Resume.pdf"
end

local function get_settings_path(cv_path)
	local path = vim.fn.fnamemodify(cv_path, ":h") .. "/settings.yaml"
	if vim.fn.filereadable(path) == 0 then
		return nil
	end
	return path
end

local function reload_pdf(expected_pdf_path)
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_get_name(buf) == expected_pdf_path then
			vim.api.nvim_buf_call(buf, function()
				vim.cmd("edit!")
			end)
			return
		end
	end
end

-- ─────────────────────────────────────────────────────────────
-- Autocommand
-- ─────────────────────────────────────────────────────────────

vim.api.nvim_create_autocmd("BufWritePost", {
	-- The file can be in any path (**/)
	-- Inside a directory named exactly "CV"
	-- The file:
	--  ~ can have any name (*)
	--  ~ must end with _CV.yaml
	pattern = "**/CV/*_CV.yaml",
	callback = function(args)
		local cv_path = vim.api.nvim_buf_get_name(args.buf)

		-- Debounce
		if render_timer then
			render_timer:stop()
			render_timer:close()
			render_timer = nil
		end

		---@diagnostic disable-next-line: undefined-field
		render_timer = uv.new_timer()
		render_timer:start(
			DEBOUNCE_MS,
			0,
			vim.schedule_wrap(function()
				local settings_path = get_settings_path(cv_path)
				if not settings_path then
					vim.notify("❌ settings.yaml not found", vim.log.levels.ERROR)
					return
				end

				vim.notify("🔄 RenderCV: rendering PDF...", vim.log.levels.INFO)

				local pdf_name = get_pdf_name(cv_path)
				local cv_dir = vim.fn.fnamemodify(cv_path, ":h")
				local expected_pdf_path = cv_dir .. "/" .. pdf_name

				vim.fn.jobstart({
					"rendercv",
					"render",
					cv_path,
					"--cv.name", -- resume title
					"Sergio Lopez Ornelas",
					"--settings", -- settings.yaml
					settings_path,
					"--settings.render_command.pdf_path", -- pdf name
					pdf_name,
				}, {
					on_exit = function(_, code)
						if code ~= 0 then
							vim.notify("❌ RenderCV failed", vim.log.levels.ERROR)
							return
						end

						vim.defer_fn(function()
							reload_pdf(expected_pdf_path)
						end, 200)
					end,
				})
			end)
		)
	end,
})
