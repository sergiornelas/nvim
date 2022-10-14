local nvim_autopairs_ok, nvim_autopairs = pcall(require, "nvim-autopairs")
if not nvim_autopairs_ok then
	return
end

local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
	return
end

nvim_autopairs.setup({
	check_ts = true, -- treesitter integration
	disable_filetype = { "TelescopePrompt" },
	map_c_h = true,
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({}))
