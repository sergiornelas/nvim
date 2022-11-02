local dim_ok, dim = pcall(require, "dim")
if not dim_ok then
	return
end

dim.setup()
