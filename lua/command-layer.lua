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

local keymap = vim.keymap.set
local opts = { silent = true }

keymap("", "&", "#") --                                     Q
keymap("", "+", ":keepjumps norm! '{'<CR>", opts) --        R
keymap("x", "+", ":<c-u>keepjumps norm! gv{'<CR>", opts) -- R
keymap("", "$", "(") --                                     I
keymap("", "%", ")") --                                     O
keymap("", ")", "^") --                                     A
keymap("", "(", "*") --                                     D
keymap("", "-", ":keepjumps norm! '}'<CR>", opts) --        F
keymap("x", "-", ":<c-u>keepjumps norm! gv}'<CR>", opts) -- F
keymap("", "[", "$") --                                     G
keymap("", "]", "=") --                                     H
keymap("", "]<space>", "==") --                             H
keymap("o", "=", "<PlugitOperationForward)") --             J
keymap("n", "=", "<Plug>(MatchitNormalForward)") --         J
keymap("x", "=", "<Plug>(MatchitVisualForward)") --         J
keymap("", "|", "&") --                                     K
keymap("", "!", "@") --                                     Z
keymap("n", "!!", "@@") --                                  ZZ
keymap("", "{", "`") --                                     V
keymap("", "{{", "``") --                                   VV
keymap("", "@", "!") --                                     B
keymap("", "`", "~") --                                     N
keymap("", "}", "|") --                                     M
