local trailspace_ok, trailspace = pcall(require, "mini.trailspace")
if not trailspace_ok then
	return
end

trailspace.setup()
