local registers_ok, registers = pcall(require, "registers")
if not registers_ok then
	return
end

registers.setup({
	grace_period = 3,
})
