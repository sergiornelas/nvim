-- COMMAND SUBSTITUTION
-- Decided to change vim default navigation keymaps because sometimes they are a pain in
-- the ass. Writing layer uses semicolon (;), it's managed by Karabiner:
-- https://github.com/sergiornelas/MacOS-Dotfiles/blob/main/karabiner/karabiner.json#L74-L535

--  WRITING       VIM EFFECT
-- ---------------------------
-- &?/+* #$% \^   #?/{   () \^
-- QWERT˙UIO      QWER˙˙˙IO
--  );(-[]=|~      ^;*}$|%&~
--  ASDFGHJKL      ASDFGHJKL
--   ! _{@`}        @ _`!~=
--   Z˙CVBNM        Z˙CVBNM

-- QD are using hlslens plugin, it's has the same effect.
-- +]-[ missing vim effect.
-- ~^ are available for mapping (~ repeated in N).
-- T and U are already mapped by Treesitter climber.
-- \ is already mapped for move through diagnostics and go to head element.

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "(", "*<cmd>lua require('hlslens').start()<cr>", opts) --               Q
keymap("x", "(", 'y/\\V<c-r>"<CR><cmd>lua require("hlslens").start()<cr>', opts) -- Q
keymap("", "+", ":keepjumps norm! '{'<CR>", opts) --                                R
keymap("x", "+", ":<c-u>keepjumps norm! gv{'<CR>", opts) --                         R
keymap("", "$", "(") --                                                             I
keymap("", "%", ")") --                                                             O
keymap("", ")", "^") --                                                             A
keymap("n", "&", "#<cmd>lua require('hlslens').start()<cr>", opts) --               D
keymap("x", "&", 'y?\\V<c-r>"<CR><cmd>lua require("hlslens").start()<cr>', opts) -- D
keymap("", "-", ":keepjumps norm! '}'<CR>", opts) --                                F
keymap("x", "-", ":<c-u>keepjumps norm! gv}'<CR>", opts) --                         F
keymap("", "[", "$") --                                                             G
keymap("", "]", "|") --                                                             H
keymap("n", "=", "<Plug>(MatchitNormalForward)") --                                 J
keymap("o", "=", "<Plug>(MatchitOperationForward)") --                              J
keymap("x", "=", "<Plug>(MatchitVisualForward)") --                                 J
keymap("", "|", "&") --                                                             K
keymap("", "!", "@") --                                                             Z
keymap("n", "!!", "@@") --                                                          ZZ
keymap("", "{", "`") --                                                             V
keymap("", "{{", "``") --                                                           VV
keymap("", "@", "!") --                                                             B
keymap("", "`", "~") --                                                             N
keymap("", "}", "=") --                                                             M
