local M = {}

M.comment = function()
   local present, comment = pcall(require, "Comment")
   if present then
     comment.setup()
   end
end

return M
