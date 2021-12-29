local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

toggleterm.setup({
  size = 120,
  direction = 'float',
  float_opts = {
    border = 'single',
    width = 100,
    winblend =30,
  },
})
