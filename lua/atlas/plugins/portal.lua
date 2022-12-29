local portal_ok, portal = pcall(require, "portal")
if not portal_ok then
	return
end

portal.setup({
	query = { "modified", "different", "valid", "grapple" },
	labels = { "j", "k", "h", "l" },
	-- backward = "<c-i>",
	-- forward = "<c-o>",
	integrations = {
		grapple = true,
	},
})

vim.keymap.set("n", "J", portal.jump_backward, {})
vim.keymap.set("n", "K", portal.jump_forward, {})
