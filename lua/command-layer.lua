-- COMMAND SUBSTITUTION
-- Decided to change vim default navigation keymaps because sometimes they are a pain in the ass.
-- Writing layer uses semicolon (;), it's managed by Karabiner:
-- https://github.com/sergiornelas/MacOS-Dotfiles/blob/main/karabiner/karabiner.json#L74-L535

--  WRITING           VIM EFFECT
-- -------------------------------
-- &?/+* #$% \^       #?/{   () \^
-- QWERT˙UIO          QWER˙˙˙IO
--  );(-[]=|~          ^;*}$=%&~
--  ASDFGHJKL          ASDFGHJKL
--   ! _{@`}            @ _`!~|
--   Z˙CVBNM            Z˙CVBNM

-- +]-[ missing vim effect
-- ~^ are available for mapping (~ repeated in N)
-- T and U are already mapped by Treesitter climber
-- \ is already mapped for move through diagnostics and go to head element

vim.keymap.set("", "&", "#") --         Q
vim.keymap.set("", "+", "{") --         R
vim.keymap.set("", "$", "(") --         I
vim.keymap.set("", "%", ")") --         O
vim.keymap.set("", ")", "^") --         A
vim.keymap.set("", "(", "*") --         D
vim.keymap.set("", "-", "}") --         F
vim.keymap.set("", "[", "$") --         G
vim.keymap.set("", "]", "==") --        H
vim.keymap.set("x", "]", "==<esc>") --  H
vim.keymap.set("o", "=", "<Plug>(MatchitOperationForward)") -- J
vim.keymap.set("n", "=", "<Plug>(MatchitNormalForward)") --    J
vim.keymap.set("x", "=", "<Plug>(MatchitVisualForward)") --    J
vim.keymap.set("", "|", "&") --         K
vim.keymap.set("n", "!", "@") --        Z
vim.keymap.set("n", "!!", "@@") --      ZZ
vim.keymap.set("", "{", "`") --         V
vim.keymap.set("", "{{", "``") --       VV
vim.keymap.set("", "@", "!") --         B
vim.keymap.set("", "`", "~") --         N
vim.keymap.set("", "}", "|") --         M
