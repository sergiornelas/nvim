-- COMMAND SUBSTITUTION
-- Decided to change vim default navigation keymaps because sometimes they are a pain in
-- the ass. Writing layer uses semicolon (;), it's managed by Karabiner:
-- https://github.com/sergiornelas/MacOS-Dotfiles/blob/main/karabiner/karabiner.json#L141-L621

--  WRITING       VIM EFFECT
-- ---------------------------
-- &?/+* #$~ \^   ˙?/{˙ #$~ \^
-- QWERT˙UIO˙     QWERT˙UIO˙
--  ()=-[];|       ^=*}$˙%|˙
--  ASDFGHJK˙      ASDFGHJK˙
--   !%_{}@`        ,%;`˙˙`
--   ZXCVBNM        ZXCVBNM

-- Y, P, L are ignored by the writing layer, difficult to type
-- Plugins:
--    T/N are mapped for illuminate
--    Q/B/H are mapped for nvim-recorder
--    Z/C are mapped for flash
--      , is mapped for neorg keymaps
--      \ is mapped for various plugins
--      @ is replaced by nvim-recorder

-- I, ^, K, X, M             are free for vim effect (repeated or useless (K))
-- &, +, (, ), -, [, ], !, _ missing mapped vim effect

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("", "+", ":keepjumps norm! '{'<cr>", opts) --        R
keymap("x", "+", ":<c-u>keepjumps norm! gv{'<cr>", opts) -- R
keymap("x", "#", 'y?\\V<c-r>"<cr><cmd>AutoHlsearch<cr>') -- U
keymap("", "(", "^") --                                     A
keymap("", ")", "=") --                                     S
keymap("", "=", "*<cmd>AutoHlsearch<cr>") --                D
keymap("x", "=", 'y/\\V<c-r>"<cr><cmd>AutoHlsearch<cr>') -- D
keymap("", "-", ":keepjumps norm! '}'<cr>", opts) --        F
keymap("x", "-", ":<c-u>keepjumps norm! gv}'<cr>", opts) -- F
keymap("", "[", "$") --                                     G
keymap("", ";", "%") --                                     J
keymap("", "{", "`") --                                     V
keymap("", "{#", "`u") --                                  VU
keymap("", "{$", "`i") --                                  VI
keymap("", "{;", "`j") --                                  VJ
keymap("", "{`", "`m") --                                  VM
keymap("", "{|", "`k") --                                  VK
keymap("", "{{", "``") --                                  VV

-- NOTES
-- You could think that you can map W (?) for a different one
-- because you don't use (?) quite often, but mapping W (?) it's impossible,
-- (expects an after-key, similar when you used 'vv' for visual line).

-- V for mark is cool, you need to use marks more often.

-- TN is more confortable than DU.
