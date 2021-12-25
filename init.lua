local impatient, impatient = pcall(require, "impatient")
if impatient then
   -- NOTE: currently broken, will fix soon
   --impatient.enable_profile()
end

--disable builtin plugins
local disabled_built_ins = {
   "2html_plugin",
   "getscript",
   "getscriptPlugin",
   "gzip",
   "logipat",
   "netrw",
   "netrwPlugin",
   "netrwSettings",
   "netrwFileHandlers",
   "matchit",
   "tar",
   "tarPlugin",
   "rrhelper",
   "spellfile_plugin",
   "vimball",
   "vimballPlugin",
   "zip",
   "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
   vim.g["loaded_" .. plugin] = 1
end

require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
require "user.lsp"
require "user.treesitter"
require "user.telescope"
require "user.others".comment()
-- require "user.nvimtree"

-- -- load options, mappings, and plugins
-- local modules = {
--    "options",
--    "mappings",
--    "packer_compiled",
-- }
--
-- for i = 1, #modules, 1 do
--    pcall(require, modules[i])
-- end
