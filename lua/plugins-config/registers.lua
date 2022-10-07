local registers_status_ok, registers = pcall(require, "registers")
if not registers_status_ok then
	return
end

registers.setup({
	grace_period = 3,
})
