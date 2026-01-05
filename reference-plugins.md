# Reference plugins

## LSP

hedyhli/outline.nvim                                    enhanced symbols-outline.nvim
stevearc/aerial.nvim                                                 LSP Diagram menu
ray-x/navigator.lua                                                      LSP hardcore
folke/neoconf.nvim                             global/project-local lsp settings live
VidocqH/lsp-lens.nvim                 show definition and references (takes one line)
joechrisellis/lsp-format-modifications.nvim  run autoformatter over the changed lines
ThePrimeagen/refactoring.nvim                                             refactoring
artemave/workspace-diagnostics.nvim            Populates project-wide lsp diagnostics

## Treesitter

CKolkey/ts-node-action                                           (mature for jsx/tsx)
filNaj/tree-setter  typescript space bar snippets (wait for compatibility for js/tsx)

## Debugging

mfusseneger/nvim-dap
sakhnik/nvim-gdb
rcarriga/nvim-dap-ui
Pocco81/DAPInstall.nvim
Weissle/persistent-breakpoints.nvim
theHamsta/nvim-dap-virtual-text
ravenxrz/DAPInstall.nvim
Lommix/godot.nvim
niuiic/dap-utils.nvim
andrewferrier/debugprint.nvim
igorlfs/nvim-dap-view                                         more modern debugger UI
miroshQa/debugmaster.nvim                        dap-ui alternativedap-ui alternative

## Testing

David-Kunz/jester
EthanJWright/vs-tasks.nvim                                      terminal test results
stevearc/overseer.nvim                                         ttr (exe cmds on save)
andythigpen/nvim-coverage                                                    coverage

## Git

tpope/vim-fugitive                                                        most robust
NeogitOrg/neogit                                                                magit
akinsho/git-conflict.nvim                                                   conflicts
pwntester/octo.nvim                                                            git PR
ruifm/gitlinker.nvim                                                    add bitbucket
ray-x/forgit.nvim                                                        git commands
aaronhallaert/advanced-git-search.nvim                      git telescope integration
fredeeb/tardis.nvim                                    time travel current buffer git
isak102/telescope-git-file-history.nvim                 open/preview the current file
FabijanZulj/blame.nvim                                         git blame in all lines
echasnovski/mini-git                                          vim-fugitive for neovim
SuperBo/fugit2.nvim                                                    neovim git GUI
isakbm/gitgraph.nvim                                      git graph plugin for neovim
tanvirtin/vgit.nvim/tree/v1.0.x                           enhance your git experience

## Frontend

vuki656/package-info.nvim                show packages latest version in package.json
b0o/SchemaStore.nvim                                                      json schema
gennaro-tedesco/nvim-jqx                                             json in quickfix
rest-nvim/rest.nvim                                                           postman
mistweaverco/kulala.nvim                                                HTTP requests
vinnymeller/swagger-preview.nvim                                      swagger preview
ray-x/web-tools.nvim                                         live server for html/css
barrett-ruth/import-cost.nvim                                  cost memory of imports
tomiis4/hypersonic.nvim                                         explanation for regex
yioneko/nvim-vtsls                                   replacement for typescript-tools
neoclide/coc.nvim                                    replacement for typescript-tools
cjodo/convert.nvim                                    convert px to rem and viceversa
Julien-cpsn/ATAC                                           Postman in your terminal!!
typed-rocks/ts-worksheet-neovim                 live Results In Neovim in js/ts files
mfussenegger/nvim-lint                                  linters like eslint (popular)
esmuellert/nvim-eslint                           more native VSCode eslint for neovim
marilari88/twoslash-queries.nvim               print typescript types as virtual text
jdrupal-dev/code-refactor.nvim                          more javascripts code actions
jellydn/typecheck.nvim               seamless TypeScript type checking using quickfix
Jezda1337/nvim-html-css                        HTML id and class attribute completion
redoxahmii/json-to-types.nvim     generating type definitions from JSON to TypeScript

## Artificial Intelligence

zbirenbaum/copilot-cmp
zbirenbaum/copilot.lua
tzachar/cmp-tabnine
aduros/ai.vim                                                          openAI and GPT
dense-analysis/neural                                                OpenAI and GPT-3
james1236/backseat.nvim          GPT to highlight and explain code readability issues
Bryley/neoai.nvim                                  brings the power of OpenAI's GPT-4
tdfacer/explain-it.nvim                     Ask a question, and let robots explain-it
svermeulen/text-to-colorscheme                    colorscheme generator with chat gpt
Robitx/gp.nvim           Gp (GPT prompt) plugin for Neovim (better than ChatGPT.nvim)
piersolenski/wtf.nvim                                diagnostics detailed explanation
CamdenClark/flyboy                                    lightweight ChatGPT interaction
gsuuon/llm.nvim                                                   use LLM's in Neovim
David-Kunz/gen.nvim                                                          llama IA
gsuuon/model.nvim                                                   another IA plugin
olimorris/codecompanion.nvim                copilot chat like experience via a buffer
milanglacier/yarepl.nvim/blob/main/extensions/README.md  ai terminal (generate files)
dlants/magenta.nvim                      ai code genereator, designed for typescript?
davidyz/vectorcode better prompt for your LLMs by providing info about the repository

## Competitive

0x100101/lab.nvim                                     visual text output (dissapears)
michaelb/sniprun                           blockvisualrun, virtual textlost, nowatch?
arjunmahishi/flow.nvim                                block visual run, fish problems
p00f/cphelper.nvim                                                    code challenges
xeluxee/competitest.nvim                                              code challenges
Vigemus/iron.nvim                              run selected area, buggy, watch works?
kawre/leetcode.nvim                                     leetcode problems with neovim
Goose97/timber.nvim              insert log statements and capture log results inline

## Notes

folke/todo-comments.nvim                                                 pretty notes
Chaitanyabsprip/present.nvim                                 power point presentation
JellyApple102/easyread.nvim                                      text colors readable
elijah-potter/harper                english grammar checker designed to be just right
3rd/diagram.nvim                               UML kind of diagrams in markdown files
obsidian-nvim/obsidian.nvim                           obsidian notes (community fork)
bngarren/checkmate.nvim                                          pretty TODO markdown

## Utils

danymat/neogen                                    comments on files for documentation
potamides/pantran.nvim                                              google translator
jghauser/kitty-runner.nvim                                   kitty commands from nvim
smjonas/live-command.nvim              visual feedback for vim search/global commands
tiagovla/scope.nvim                               workspace by tab (very interesting)
LunarVim/bigfile.nvim             disables certain features if the opened file is big
chrisgrieser/nvim-scissors               automagical editing and creation of snippets
chrisgrieser/nvim-chainsaw                       powerfull auto console.logs (mature)
rasulomaroff/reactive.nvim              cursor line colors (mature: nvim menu screen)
LintaoAmons/bookmarks.nvim                    little notes as bookmark in the project
altermo/nwm                     allows you to use x11 windows as if they were buffers
NStefan002/screenkey.nvim       displays the keys you are typing in a floating window
nvim-focus/focus.nvim                                              autoresize windows
nfrid/due.nvim                simple plugin that provides you due for the date string
luckasRanarison/clear-action.nvim code actions with fully customizable signs, actions
MagicDuck/grug-far.nvim                            find and replace plugin for neovim
VoxelPrismatic/rabbit.nvim                               remembers history per window
imNel/monorepo.nvim                         create multiple projects inside a project
tristone13th/lspmark.nvim                            bookmark persistent based on lsp
LintaoAmons/bookmarks.nvim                                notes bookmark project tree
aliqyan-21/wit.nvim                                  visit visual selected on browser
azratul/live-share.nvim                    share your changes real time with coworker
hat0uma/csvview.nvim                                       show csv spreadsheet files
sphamba/smear-cursor.nvim                          neovide cursor animation in neovim
jake-stewart/multicursor.nvim                             multiple cursors for neovim
lfilho/note2cal.nvim                                  schedule events to calendar.app
carlosrocha/chrome-remote.nvim              run browser current page HTML into neovim
mfontanini/presenterm                              powerpoint presentations in neovim
WillianPaiva/jira-nvim                Jira REST API to manage Jira from within Neovim
A7Lavinraj/fyler.nvim                                                  oil + nvimtree
folke/sidekick.nvim                              GitHub Copilot Next Edit Suggestions
Kenzo-Wada/boundary.nvim                        react nextjs 'use client' inline text
yousefhadder/markdown-plus.nvim                          markdown niceties for neovim
ahkohd/context.nvim                                     context files for claude code
letieu/jira.nvim                              managing JIRA tasks with a beautiful UI
Avi-D-coder/whisper.nvim                                  voice to text transcription

Last time revisited all these plugins
20/05/2024

---

<https://github.com/rockerBOO/awesome-neovim/commits/main/>
Jan 05, 2025 (Update cuducos.me/yaml.nvim)

<https://dotfyle.com/neovim/plugins/new>
muhfaris/prayertime.nvim

---

<https://dotfyle.com/this-week-in-neovim>
1/6/2025
