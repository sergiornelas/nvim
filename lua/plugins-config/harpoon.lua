local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local h_status_ok, harpoon = pcall(require, "harpoon")
if not h_status_ok then
	return
end

harpoon.setup({
	global_settings = {
		enter_on_sendcmd = true,
		tmux_autoclose_windows = true,
		mark_branch = false, -- set marks specific to each git branch inside git repository
	},
})

telescope.load_extension("harpoon")
