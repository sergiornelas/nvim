-- COMMAND SUBSTITUTION
-- Decided to change vim default navigation keymaps because sometimes they are a pain in
-- the ass. Writing layer uses semicolon (;), it's managed by Karabiner:
-- https://github.com/sergiornelas/MacOS-Dotfiles/blob/main/karabiner/karabiner.json#L126-L587

--  WRITING       VIM EFFECT
-- ---------------------------
-- &?/+* #$% \^   q?/{  #)( \^
-- QWERT˙UIO      QWER˙˙UIO
--  (;)-[]=|~      ^=*}$˙%&~
--  ASDFGHJKL      ASDFGHJKL
--   ! _{@}`        @ _`! ~
--   Z˙CVBNM        Z˙CVB˙M

-- Y,P,X are ignored by the writing layer, difficult to type.
-- T/N mapped for illuminate.
-- H is mapped for go to last changed line
-- M/L,^ are free for vim effect.
-- \ is already mapped by multiple plugins
-- +-][| missing mapped vim effect.

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("", "&", "q", opts) --                                             Q
keymap("", "+", ":keepjumps norm! '{'<cr>", opts) --                      R
keymap("x", "+", ":<c-u>keepjumps norm! gv{'<cr>", opts) --               R
keymap("", "$", ")") --                                                   I
keymap("", "%", "(") --                                                   O
keymap("", "(", "^") --                                                   A
keymap("", ";", "=") --                                                   S
keymap("", ")", "*") --                                                   D
keymap("x", ")", 'y/\\V<c-r>"<cr>') --                                    D
keymap("", "-", ":keepjumps norm! '}'<cr>", opts) --                      F
keymap("x", "-", ":<c-u>keepjumps norm! gv}'<cr>", opts) --               F
keymap("", "[", "$") --                                                   G
keymap("", "=", "%") --                                                   J
keymap("", "|", "&") --                                                   K
keymap("", "!", "@") --                                                   Z
keymap("x", "!", '":norm !" . getcharstr() . "<cr>"', { expr = true }) -- Z
keymap("", "!!", "@@") --                                                 ZZ
keymap("", "{", "`") --                                                   V
keymap("", "{{", "``") --                                                 VV
keymap("", "@", "!") --                                                   B
keymap("", "`", "~") --                                                   M

-- NOTES
-- gi/go for git hunk navigation it's quite confortable.

-- You could think that you can map W (?) for a different one
-- because you don't use (?) quite often, but mapping W (?) it's impossible,
-- (expects an after-key, similar when you used 'vv' for visual line).

-- V for mark is cool, you need to use marks more often.

-- QZ | UM are bad idea for illuminate because you need a different finger.
-- TN is more confortable than DU.

-- ==============================
-- SATURDAY:
-- Repare fish
-- Arregle ssh key
-- Aprendi git user.name & user.email
-- Determine screen resolution and font size for 16"
-- Misc:
--   Lazy.nvim keys with visual mode
--   Diffview maps
--   Tried karabiner multiple files and cleaning
--   Delta side-side
--   Some neovim remapping
-- SUNDAY:
-- remap keymap layer
-- remap vim effect (macros, etc)
-- new kitty next/prev tab keymap
-- restructured text-objects
-- replace to vimium-c instead of karabiner
-- added new app alt-tab
