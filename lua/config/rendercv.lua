-- Instructions
-- Run this command inside a directory named "CV":
-- > rendercv new "JohnDoe-Resume"
-- Inside the "CV" directory create the settings.yaml file. Docs:
-- https://docs.rendercv.com/user_guide/yaml_input_structure/settings/

local OUTPUT_DIR = "rendercv_output"
local uv = vim.uv or vim.loop
local render_timer = nil

-- ─────────────────────────────────────────────────────────────
-- Config ⚙️
-- ─────────────────────────────────────────────────────────────
local DEBOUNCE_MS = 300
local DEBOUNCE_VIM_RESIZE_MS = 600
local DEFAULT_PDF_NAME = "SergioOrnelas-Resume.pdf"
local RESUME_TITLE = "Sergio Lopez Ornelas"
local PDF_BY_PROFILE = {
	-- [keyword in yaml file name]                custom filename
	Frontend = OUTPUT_DIR .. "/SergioOrnelas-Frontend-Resume.pdf",
	Backend = OUTPUT_DIR .. "/SergioOrnelas-Backend-Resume.pdf",
	Fullstack = OUTPUT_DIR .. "/SergioOrnelas-Fullstack-Resume.pdf",
	-- Example:
	-- Cloud = OUTPUT_DIR .. "/Cloud-resume.pdf",
	-- Now, everytime you save *Cloud*.yaml, it will generate/overwrite Cloud-resume.pdf
}

-- ─────────────────────────────────────────────────────────────
-- Helpers
-- ─────────────────────────────────────────────────────────────
local function get_pdf_name(cv_path)
	for key, pdf in pairs(PDF_BY_PROFILE) do
		if cv_path:match(key) then
			return pdf
		end
	end
	-- ⚠️ If you save a yaml file that doesn't match any PDF_BY_PROFILE, it will overwrite the DEFAULT_PDF_NAME
	return OUTPUT_DIR .. "/" .. DEFAULT_PDF_NAME
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
		local yaml_file_path = vim.api.nvim_buf_get_name(args.buf)

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
				local settings_path = get_settings_path(yaml_file_path)
				if not settings_path then
					vim.notify("❌ settings.yaml not found", vim.log.levels.ERROR)
					return
				end

				vim.notify("🔄 RenderCV: rendering PDF...", vim.log.levels.INFO)

				local pdf_name = get_pdf_name(yaml_file_path)
				local cv_dir = vim.fn.fnamemodify(yaml_file_path, ":h")
				local expected_pdf_path = cv_dir .. "/" .. pdf_name

				vim.fn.jobstart({
					"rendercv",
					"render",
					yaml_file_path,
					"--cv.name", -- resume title
					RESUME_TITLE,
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

vim.api.nvim_create_autocmd("VimResized", {
	pattern = "**/CV/*_CV.yaml",
	callback = function(args)
		local buf = args.buf
		if not buf or not vim.api.nvim_buf_is_valid(buf) then
			return
		end
		local yaml_file_path = vim.api.nvim_buf_get_name(buf)
		if not yaml_file_path:match("CV/[^/]+_CV%.yaml$") then
			return
		end
		-- Debounce
		if render_timer then
			render_timer:stop()
			render_timer:close()
			render_timer = nil
		end
		---@diagnostic disable-next-line: undefined-field
		render_timer = vim.loop.new_timer()
		render_timer:start(
			DEBOUNCE_VIM_RESIZE_MS,
			0,
			vim.schedule_wrap(function()
				local pdf_name = get_pdf_name(yaml_file_path)
				local cv_dir = vim.fn.fnamemodify(yaml_file_path, ":h")
				reload_pdf(cv_dir .. "/" .. pdf_name)
			end)
		)
	end,
})
