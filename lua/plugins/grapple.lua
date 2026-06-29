local M = {
	"cbochs/grapple.nvim",
	event = "BufReadPost",
	keys = {
		{ "g<leader>", "<cmd>Grapple toggle<cr>" },
		{ "<leader>go", "<cmd>Grapple open_tags<cr>" },
		{ "<leader>gk", "<cmd>Grapple open_tags scope=bookmarks<cr>" },
		{ "<leader>ga", "<cmd>Grapple open_tags scope=global<cr>" },
		{ "<leader>g<leader>", ":Grapple tag scope=bookmarks name=" },
		{ "<leader>gy", ":Grapple tag scope=global name=~" },
		{ "<leader>gq", "<cmd>Grapple quickfix<cr>" },
		{ "<leader>1", "<cmd>Grapple select index=1<cr>" },
		{ "<leader>2", "<cmd>Grapple select index=2<cr>" },
		{ "<leader>3", "<cmd>Grapple select index=3<cr>" },
		{ "<leader>4", "<cmd>Grapple select index=4<cr>" },
		{ "<leader>5", "<cmd>Grapple select index=5<cr>" },
		{ "<leader>6", "<cmd>Grapple select index=6<cr>" },
		{ "<leader>7", "<cmd>Grapple select index=7<cr>" },
		{ "<leader>8", "<cmd>Grapple select index=8<cr>" },
		{ "<leader>9", "<cmd>Grapple select index=9<cr>" },
		{ "<leader>0", "<cmd>Grapple select index=10<cr>" },
		{ "<c-g>", "<cmd>Grapple cycle_tags next<cr>" }, -- (vim: display current file name and position)
		{ "<c-t>", "<cmd>Grapple cycle_tags prev<cr>" }, -- (vim: jump to N older Tag in tag list)
		{ "[1", "<cmd>Grapple select scope=bookmarks index=1<cr>" },
		{ "[2", "<cmd>Grapple select scope=bookmarks index=2<cr>" },
		{ "[3", "<cmd>Grapple select scope=bookmarks index=3<cr>" },
		{ "[4", "<cmd>Grapple select scope=bookmarks index=4<cr>" },
		{ "[5", "<cmd>Grapple select scope=bookmarks index=5<cr>" },
		{ "[6", "<cmd>Grapple select scope=bookmarks index=6<cr>" },
		{ "[7", "<cmd>Grapple select scope=bookmarks index=7<cr>" },
		{ "[8", "<cmd>Grapple select scope=bookmarks index=8<cr>" },
		{ "[9", "<cmd>Grapple select scope=bookmarks index=9<cr>" },
		{ "[0", "<cmd>Grapple select scope=bookmarks index=10<cr>" },
	},
}

function M.config()
	local grapple_ok, grapple = pcall(require, "grapple")
	if not grapple_ok then
		return
	end

	-- Grapple's tag list only fetches icons from nvim-web-devicons. Feed it a shim whose
	-- get_icon returns a real-icons terminal-image placeholder (text + highlight group)
	-- via the public API (real-icons.get_icon, >= c5fc98c), which grapple drops into the
	-- line and highlights.
	local tc_ok, TagContent = pcall(require, "grapple.tag_content")
	local ri_ok, real_icons = pcall(require, "real-icons")
	-- Only enable grapple icons when the real-icons shim can actually be installed;
	-- otherwise `icons = true` would error on open (it requires nvim-web-devicons).
	local real_icons_available = tc_ok and ri_ok and type(real_icons.get_icon) == "function"
	if real_icons_available and not TagContent._real_icons_wrapped then
		local shim = {
			setup = function() end,
			has_loaded = function()
				return true
			end,
			get_icon = function(name)
				local ok, text, hl = pcall(real_icons.get_icon, "file", name or "")
				if ok and text then
					return text, hl
				end
			end,
		}
		local original_create_entry = TagContent.create_entry
		TagContent.create_entry = function(self, ...)
			local saved = package.loaded["nvim-web-devicons"]
			package.loaded["nvim-web-devicons"] = shim
			local ok, entry = pcall(original_create_entry, self, ...)
			package.loaded["nvim-web-devicons"] = saved
			if not ok then
				error(entry, 0) -- re-raise without prepending this wrapper's location
			end
			return entry
		end
		TagContent._real_icons_wrapped = true
	end

	grapple.setup({
		name_pos = "start",
		style = "basename",
		icons = real_icons_available,
		-- Avoid reloading the buffer (and re-attaching the LSP) when selecting
		-- the file you're already in. Only :edit when the target differs.
		command = function(path)
			local target = vim.fn.fnamemodify(path, ":p")
			local current = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")
			if target ~= current then
				vim.cmd.edit(vim.fn.fnameescape(path))
			end
		end,
		win_opts = {
			width = 70,
		},
		scopes = {
			{
				name = "bookmarks",
				fallback = "cwd",
				cache = { event = "DirChanged" },
				resolver = function()
					---@diagnostic disable-next-line: undefined-field
					local root = vim.loop.cwd()
					local id = string.format("%s:%s", root, "bookmarks")
					local path = root
					return id, path
				end,
			},
		},
	})
end

return M
