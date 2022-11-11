-- COMMAND SUBSTITUTION
-- Decided to change vim default navigation keymaps because sometimes they are a pain in
-- the ass. Writing layer uses semicolon (;), it's managed by Karabiner:
-- https://github.com/sergiornelas/MacOS-Dotfiles/blob/main/karabiner/karabiner.json#L74-L535

--  WRITING       VIM EFFECT
-- ---------------------------
-- &?/+* #$% \^   #?/{  #() \^
-- QWERT˙UIO      QWER˙˙UIO
--  );(-[]=|~      ^;*}$|%&~
--  ASDFGHJKL      ASDFGHJKL
--   ! _{@`}        @ _`! =
--   Z˙CVBNM        Z˙CVB˙M

-- +]-[ missing vim effect.
-- #^ are available for mapping
-- T and N are mapped by Illuminate
-- \ is already mapped by multiple plugins

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("", "&", "#") --                                     Q
keymap("x", "&", 'y?\\V<C-R>"<CR>') --                      Q
keymap("", "+", ":keepjumps norm! '{'<CR>", opts) --        R
keymap("x", "+", ":<c-u>keepjumps norm! gv{'<CR>", opts) -- R
keymap("", "$", "(") --                                     I
keymap("", "%", ")") --                                     O
keymap("", ")", "^") --                                     A
keymap("", "(", "*") --                                     D
keymap("x", "(", 'y/\\V<C-R>"<CR>') --                      D
keymap("", "-", ":keepjumps norm! '}'<CR>", opts) --        F
keymap("x", "-", ":<c-u>keepjumps norm! gv}'<CR>", opts) -- F
keymap("", "[", "$") --                                     G
keymap("", "]", "|") --                                     H
keymap("n", "=", "<Plug>(MatchitNormalForward)") --         J
keymap("o", "=", "<Plug>(MatchitOperationForward)") --      J
keymap("x", "=", "<Plug>(MatchitVisualForward)") --         J
keymap("", "|", "&") --                                     K
keymap("", "!", "@") --                                     Z
keymap("n", "!!", "@@") --                                  ZZ
keymap("", "{", "`") --                                     V
keymap("", "{{", "``") --                                   VV
keymap("", "@", "!") --                                     B
keymap("", "}", "=") --                                     M
