-- COMMAND SUBSTITUTION
-- Decided to change vim default navigation keymaps because sometimes they are a pain in
-- the ass. Writing layer uses semicolon (;), it's managed by Karabiner:
-- https://github.com/sergiornelas/MacOS-Dotfiles/blob/main/karabiner/karabiner.json#L124-L585

--  WRITING       VIM EFFECT
-- ---------------------------
-- &?/+* #$% \^   #?/{  #() \^
-- QWERT˙UIO      QWER˙˙UIO
--  );(-[]=|~      ^~*}$|%&~
--  ASDFGHJKL      ASDFGHJKL
--   ! _{@`}        @ _`! =
--   Z˙CVBNM        Z˙CVB˙M

-- +]-[ missing vim effect.
-- #^~ are available for mapping (~ is repeated in S)
-- T and N are mapped by Illuminate
-- \ is already mapped by multiple plugins

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("", "&", "#<cmd>lua require('hlslens').start()<cr>") -- Q
keymap("x", "&", 'y?\\V<c-r>"<cr>') --                         Q
keymap("", "+", ":keepjumps norm! '{'<cr>", opts) --           R
keymap("x", "+", ":<c-u>keepjumps norm! gv{'<cr>", opts) --    R
keymap("", "$", "(") --                                        I
keymap("", "%", ")") --                                        O
keymap("", ")", "^") --                                        A
keymap("", ";", "=") --                                        S
keymap("", "(", "*<cmd>lua require('hlslens').start()<cr>") -- D
keymap("x", "(", 'y/\\V<c-r>"<cr>') --                         D
keymap("", "-", ":keepjumps norm! '}'<cr>", opts) --           F
keymap("x", "-", ":<c-u>keepjumps norm! gv}'<cr>", opts) --    F
keymap("", "[", "$") --                                        G
keymap("", "]", "|") --                                        H
keymap("n", "=", "<Plug>(MatchitNormalForward)") --            J
keymap("o", "=", "<Plug>(MatchitOperationForward)") --         J
keymap("x", "=", "<Plug>(MatchitVisualForward)") --            J
keymap("", "|", "&") --                                        K
keymap("", "!", "@") --                                        Z
keymap("n", "!!", "@@") --                                     ZZ
keymap("", "{", "`") --                                        V
keymap("", "{{", "``") --                                      VV
keymap("", "@", "!") --                                        B
keymap("", "}", "~") --                                        M
