# Artificial Intelligence

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

## Copilot LSP

copilotlsp-nvim/copilot-lsp                      Copilot LSP Configuration for Neovim
<https://www.reddit.com/r/neovim/comments/1k4ad2z/copilotlsp_next_edit_suggestioncompletions_and/>
<https://www.reddit.com/r/neovim/comments/1jw7pmm/use_lsp_as_context_provider_in_codecompanion/>

## Misc

<https://l-o-o-s-e-d.net/vibe-coding>      article vibe coding in neovim (voice chat)
kyza0d/vocal.nvim           speech-to-text transcription using the OpenAI Whisper API

## Claude code

<https://github.com/samir-roy/code-bridge.nvim>

## Open code

<https://github.com/opencode-ai/opencode?tab=readme-ov-file>
<https://www.reddit.com/r/neovim/comments/1lx9con/update_cursorwindsurf_for_neovim/>

## Magenta

<https://github.com/dlants/magenta.nvim>
<https://www.reddit.com/r/neovim/comments/1ly71bv/my_neovim_ai_workflow/>
