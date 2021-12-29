local M = {}

M.colorizer = function()
  local present, colorizer = pcall(require, "colorizer")
  if present then
    colorizer.setup({ "*" }, {
      RGB = true, -- #RGB hex codes
      RRGGBB = true, -- #RRGGBB hex codes
      mode = "foreground", -- Set the display mode.
    })
    -- vim.cmd "ColorizerReloadAllBuffers"
  end
end

M.comment = function()
   local present, comment = pcall(require, "Comment")
   if present then
     comment.setup()
   end
end

return M
