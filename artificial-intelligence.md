# Artificial Intelligence

## Avante

You can use lualine to show the avante status in the statusline.
Recognize avante "todo" and "code" sections

## Cursor IDE

### Avante vs Cursor IDE

- `Me`: Do you think there will be a point where avante.nvim matches the
        features that Cursor IDE offers?
- `A guy`: It’s getting damn close. But it requires a quite a bit of
           post-install configuration to get it "damn close".
- `Me`: What kind of post-installation configuration is needed?
- `A guy`:
<https://github.com/yetone/avante.nvim/blob/main/cursor-planning-mode.md>

### Cursor Tab

reachingforthejack/cursortab.nvim                       cursor tab reverse engineered
<https://www.reddit.com/r/neovim/comments/1jwj0h2/reverse_engineered_cursor_tab_api_in_neovim/>

<https://github.com/dlants/magenta.nvim>

Next prediction features, (Really cool):
<https://github.com/copilotlsp-nvim/copilot-lsp>

Adding Next Edit Suggestions to (in process):
<https://github.com/NickvanDyke/opencode.nvim>

Replicate Cursor tab functionality
<https://github.com/zbirenbaum/copilot.lua/commit/2ac3ab31c73ebf4b91247962c6ab6efc22d1fdf7>

AI-powered next-edit suggestions (NES) for Neovim.
<https://github.com/jim-at-jibba/nvim-stride>

<https://github.com/leonardcser/cursortab.nvim>

<https://www.reddit.com/r/neovim/comments/1qqu3lw/we_built_a_purelua_cursor_alternative_for_neovim/>
<https://github.com/BlinkResearchLabs/blink-edit.nvim>

### Related plugins

banjo/contextfiles.nvim                                                  cursor rules
kbwo/vim-shareedit        shares open files and cursor positions in Neovim and VSCode
yuucu/cursor_open.nvim                      open files in Cursor directly from Neovim

## MCP

ravitemer/mcphub.nvim                                              avante integration

Make sure you integrate the `MCPHub plugin` into `Avante` and install the
`memory` and `sequentialthinkng` MCP servers. It’s really quite incredible
the quality of code that Avante can generate with this `MCPHub` plugin.

- Yetone:
mcphub.nvim's approach to installing MCP server is incredibly clever. It
directly calls avante.nvim itself to automatically install and configure MCP
server using its built-in tools. Users don't need to face any forms, manually
input anything, or edit JSON - they just need to keep deciding yes or no. It's
so elegant that it even outperforms all GUI MCP clients! I mean, completely
outperforms!

## Aider

<https://aider.chat/>              check this, it's the best competitor vs cursor IDE
GeorgesAlkhouri/nvim-aider                     seamlessly integrate Aider with Neovim
<https://www.reddit.com/r/neovim/comments/1m66jxj/aider/>
No need for a plugin imo. aider —watch-files in a separate terminal works pretty
well.

## Copilot LSP

copilotlsp-nvim/copilot-lsp                      Copilot LSP Configuration for Neovim
<https://www.reddit.com/r/neovim/comments/1k4ad2z/copilotlsp_next_edit_suggestioncompletions_and/>
<https://www.reddit.com/r/neovim/comments/1jw7pmm/use_lsp_as_context_provider_in_codecompanion/>
Satanic symbols when copilot is working in the background:
<https://github.com/samiulsami/copilot-eldritch.nvim>

## Claude code

<https://github.com/samir-roy/code-bridge.nvim>
<https://github.com/S1M0N38/ccusage.nvim>
<https://github.com/greggh/claude-code.nvim>
<https://github.com/coder/claudecode.nvim>
<https://github.com/wtfox/claude-chat.nvim>
<https://github.com/koushikxd/resu.nvim>
<https://www.reddit.com/r/neovim/comments/1p9prpr/plugin_release_resunvim_plugin_to_see_live_file/>

<https://www.reddit.com/r/neovim/comments/1pbi32i/tips_for_configuring_neovim_for_claude_code/>
<https://www.reddit.com/r/neovim/comments/1q5vx0k/claudecontextnvim_send_buffer_context_to_claude/>

<https://www.reddit.com/r/neovim/comments/1qdhwd2/forked_coderclaudecodenvim_and_added_some_nice/>
<https://github.com/snirt/claudecode.nvim>

<https://www.reddit.com/r/neovim/comments/1r37164/molenvim_plan_mode_for_humans/>
<https://github.com/zion-off/mole.nvim>

## Open code

<https://github.com/NickvanDyke/opencode.nvim>
<https://www.reddit.com/r/neovim/comments/1m2kapj/opencodenvim_my_issue_with_ai_tools_and_how_i/>
<https://github.com/sudo-tee/opencode.nvim>

## Magenta

<https://github.com/dlants/magenta.nvim>
<https://www.reddit.com/r/neovim/comments/1ly71bv/my_neovim_ai_workflow/>

## Windsurf

<https://github.com/Exafunction/windsurf.nvim>

## Folke

<https://github.com/folke/sidekick.nvim>

## Misc

<https://l-o-o-s-e-d.net/vibe-coding>      article vibe coding in neovim (voice chat)
kyza0d/vocal.nvim           speech-to-text transcription using the OpenAI Whisper API
<https://www.reddit.com/r/neovim/comments/1pugxem/best_plugin_and_workflows_for_integrating_llms/>
<https://www.reddit.com/r/neovim/comments/1pqpo8h/release_agenticnvim_ai_chat_interface_for_claude/>
