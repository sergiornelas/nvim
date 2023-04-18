-- COMMAND SUBSTITUTION
-- Decided to change vim default navigation keymaps because sometimes they are a pain in
-- the ass. Writing layer uses semicolon (;), it's managed by Karabiner:
-- https://github.com/sergiornelas/MacOS-Dotfiles/blob/main/karabiner/karabiner.json#L126-L587

--  WRITING       VIM EFFECT
-- ---------------------------
-- &?/+* #$% \^   ˙?/{˙ #)( \^
-- QWERT˙UIO˙     QWERT˙UIO˙
--  (;)-[]=|~      ^=*}$˙%&~
--  ASDFGHJKL      ASDFGHJKL
--   ! _{@}`        ! _`˙˙~
--   Z˙CVBNM        Z˙CVBNM

-- Y, P, X are ignored by the writing layer, difficult to type
-- T/N are mapped for illuminate
-- Q/B are mapped for nvim-recorder
-- H is mapped for CellularAutomaton
-- Z, M/L, ^ are free for vim effect
-- \ is already mapped by multiple plugins and actions
-- +-][| missing mapped vim effect

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("", "+", ":keepjumps norm! '{'<cr>", opts) --        R
keymap("x", "+", ":<c-u>keepjumps norm! gv{'<cr>", opts) -- R
keymap("x", "#", 'y?\\V<c-r>"<cr><cmd>AutoHlsearch<cr>') -- U
keymap("", "$", ")") --                                     I
keymap("", "%", "(") --                                     O
keymap("", "(", "^") --                                     A
keymap("", ";", "=") --                                     S
keymap("", ")", "*<cmd>AutoHlsearch<cr>") --                D
keymap("x", ")", 'y/\\V<c-r>"<cr><cmd>AutoHlsearch<cr>') -- D
keymap("", "-", ":keepjumps norm! '}'<cr>", opts) --        F
keymap("x", "-", ":<c-u>keepjumps norm! gv}'<cr>", opts) -- F
keymap("", "[", "$") --                                     G
keymap("", "=", "%") --                                     J
keymap("", "|", "&") --                                     K
keymap("", "{", "`") --                                     V
keymap("", "{#", "`u") --                                  VU
keymap("", "{=", "`j") --                                  VJ
keymap("", "{`", "`m") --                                  VM
keymap("", "{|", "`k") --                                  VK
keymap("", "{{", "``") --                                  VV
keymap("", "`", "~") --                                     M

-- NOTES
-- You could think that you can map W (?) for a different one
-- because you don't use (?) quite often, but mapping W (?) it's impossible,
-- (expects an after-key, similar when you used 'vv' for visual line).

-- V for mark is cool, you need to use marks more often.

-- TN is more confortable than DU.
