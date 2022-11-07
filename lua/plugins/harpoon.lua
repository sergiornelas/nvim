local harpoon_ok, harpoon = pcall(require, "harpoon")
if not harpoon_ok then
	return
end

harpoon.setup({
	global_settings = {
		enter_on_sendcmd = true,
		tmux_autoclose_windows = true,
		mark_branch = false, -- set marks specific to each git branch inside git repository
	},
})
