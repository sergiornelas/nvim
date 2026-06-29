local M = {
	"nvim-lualine/lualine.nvim",
	event = "BufReadPost",
}

function M.config()
	local lualine_ok, lualine = pcall(require, "lualine")
	if not lualine_ok then
		return
	end

	-- local function custom_status()
	-- 	local status = require("codeium.virtual_text").status()
	-- 	if status.state == "idle" then
	-- 		return ""
	-- 	end
	-- 	if status.state == "waiting" then
	-- 		return "󰔟"
	-- 	end
	-- 	if status.state == "completions" and status.total > 0 then
	-- 		return string.format("%d/%d", status.current, status.total)
	-- 	end
	-- 	return " 0 "
	-- end

	local function relative_dir()
		return vim.fn.expand("%:.:h")
	end

	local progress_component = {
		"progress",
		color = { bg = "", fg = "#A39D9D" },
		padding = { right = 1 },
	}

	local function grapple_component(color)
		return {
			function()
				return "󰛢 " .. require("grapple").name_or_index()
			end,
			cond = function()
				return package.loaded["grapple"] and require("grapple").exists()
			end,
			color = color,
		}
	end

	local real_icons = require("real-icons")

	local filename_hls = {
		LualineFilenameActive = { bg = "#4f0000", fg = "#ebdbb2" },
		LualineFilenameInactive = { bg = "#300000", fg = "#B0A994" },
	}
	local function set_filename_hls()
		for group, opts in pairs(filename_hls) do
			vim.api.nvim_set_hl(0, group, opts)
		end
	end
	set_filename_hls()
	vim.api.nvim_create_autocmd("ColorScheme", {
		group = vim.api.nvim_create_augroup("LualineFilenameHl", { clear = true }),
		callback = set_filename_hls,
	})

	local function filename_with_icon(hl)
		local bg = filename_hls[hl].bg
		return {
			function()
				local name = vim.fn.expand("%:t")
				if name == "" then
					name = "[No Name]"
				end
				if vim.bo.modified then
					name = name .. " [+]"
				elseif vim.bo.readonly or not vim.bo.modifiable then
					name = name .. " [-]"
				end
				-- Guard the real-icons call: if it ever errors we don't want the whole
				-- statusline to throw on every redraw. Fall back to a generic file glyph.
				local ok, text, icon_hl = pcall(real_icons.get_icon, "file", vim.fn.expand("%:p"), { bg = bg })
				local icon
				if ok and text then
					icon = "%#" .. icon_hl .. "#" .. text
				else
					icon = "%#" .. hl .. "#󰈔"
				end
				return icon .. "%#" .. hl .. "# " .. name
			end,
		}
	end

	local allowed_winbar_filetypes = {
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"html",
		"css",
		"scss",
		"json",
		"yaml",
		"markdown",
		"lua",
	}
	local function winbar_enabled()
		return vim.tbl_contains(allowed_winbar_filetypes, vim.bo.filetype)
	end

	local winbar_spacer = {
		function()
			return " "
		end,
		padding = 0,
		color = { bg = "#423E3B" },
		cond = winbar_enabled,
	}

	local lualine_config = {
		options = {
			icons_enabled = true,
			theme = "gruvbox",
			component_separators = { left = "", right = "╎" },
			section_separators = "",
			always_divide_middle = true,
			globalstatus = false,
			disabled_filetypes = {
				winbar = {},
				-- statusline = { "" },
			},
			refresh = {
				statusline = 100,
			},
		},
		sections = {
			lualine_a = {
				-- {
				-- 	custom_status,
				-- },
				progress_component,
				grapple_component({ bg = "#151517", fg = "#ebdbb2" }),
				filename_with_icon("LualineFilenameActive"),
			},
			lualine_b = { "diagnostics" },
			lualine_c = {
				{
					relative_dir,
					color = { fg = "#CFC09B" },
				},
			},
			lualine_x = { "" },
			lualine_y = { "diff" },
			lualine_z = {
				{
					-- require("opencode").statusline,
				},
			},
		},
		winbar = {
			lualine_c = { winbar_spacer, { "navic", cond = winbar_enabled } },
		},
		inactive_winbar = {
			lualine_c = { winbar_spacer },
		},
		inactive_sections = {
			lualine_a = {
				progress_component,
				grapple_component({ bg = "#151517", fg = "#A39D9D" }),
				filename_with_icon("LualineFilenameInactive"),
			},
			lualine_c = { relative_dir },
			lualine_x = {},
		},
		tabline = {},
		extensions = { "quickfix" },
	}

	lualine.setup(lualine_config)
end

return M
