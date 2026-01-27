# AGENTS.md

This file contains guidelines for agentic coding agents working in this Neovim configuration repository.

## Project Overview

This is a personal Neovim configuration using lazy.nvim as the plugin manager. The configuration is modular with:

- `init.lua` - Entry point that bootstraps lazy.nvim
- `lua/config/` - Core configuration modules (options, keymaps, autocommands, utils)
- `lua/plugins/` - Plugin specifications organized by functionality
- `lua/plugins/lsp/settings/` - Language server configurations

## Build/Lint/Test Commands

### Testing

```bash
# Run current test (cursor on test)
<leader>tj

# Run current test file
<leader>tf

# Toggle test watch mode
<leader>tw

# Toggle test summary
<leader>ts
```

### Linting/Formatting

This config uses Conform.nvim with these formatters:

- **Lua**: `stylua`
- **JavaScript/TypeScript**: `prettierd`
- **CSS/HTML/JSON**: `prettierd`
- **Markdown**: `markdownlint`

Format on save is enabled. Manual formatting:

```vim
:lua require('conform').format()
```

### Plugin Management

```bash
# Install/update plugins
:Lazy

# Clean unused plugins
:Lazy clean

# Check for plugin updates
:Lazy update

# View plugin status
:Lazy status
```

## Code Style Guidelines

### Lua Code Style

- **Indentation**: 2 spaces (no tabs)
- **Line endings**: LF
- **Max line length**: 120 characters
- **Variable naming**: `snake_case` for local variables, `UPPER_SNAKE_CASE` for constants
- **Function naming**: `snake_case` for regular functions, `PascalCase` for modules
- **File naming**: `snake_case.lua`

### Import Patterns

```lua
-- Standard vim imports
local vim = vim
local o = vim.opt
local cmd = vim.cmd
local fn = vim.fn
local api = vim.api

-- Module imports
local util = require('config.utils')
local lsp = require('lspconfig')
```

### Type Annotations

Use LuaLS comment annotations for better IDE support:

```lua
---@type table<string, boolean>
local my_table = {}

---@param name string The name to greet
---@return string The greeting message
local function greet(name)
  return "Hello, " .. name
end
```

### Plugin Configuration Pattern

```lua
return {
  "plugin/repo",
  dependencies = { "dependency1", "dependency2" },
  keys = { "<leader>k", "<leader>K" },
  cmd = { "PluginCommand" },
  event = { "BufReadPre" },
  config = function()
    -- Plugin setup code
  end,
}
```

### Error Handling

- Use `pcall()` for operations that might fail
- Provide meaningful error messages
- Gracefully handle missing dependencies:

```lua
local ok, plugin = pcall(require, 'plugin')
if not ok then
  vim.notify("Plugin not available: " .. plugin, vim.log.levels.WARN)
  return
end
```

### Key Mapping Conventions

- Use `<leader>` prefix for custom mappings
- Group related mappings under the same prefix
- Document mappings in keymaps.lua with comments:

```lua
-- Navigation
keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find files' })
keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Live grep' })
```

### LSP Configuration

- Place language server settings in `lua/plugins/lsp/settings/`
- Use the standard lspconfig pattern:

```lua
return {
  settings = {
    language_name = {
      -- Server-specific settings
    }
  },
  on_attach = function(client, bufnr)
    -- Buffer-specific setup
  end,
}
```

## File Organization

### Core Configuration

- `lua/config/options.lua` - Editor options and settings
- `lua/config/keymaps.lua` - Global key mappings
- `lua/config/autocommands.lua` - Auto commands and filetype rules
- `lua/config/utils.lua` - Utility functions

### Plugin Structure

- `lua/plugins/core.lua` - Essential plugins (colorscheme, treesitter, etc.)
- `lua/plugins/lsp.lua` - LSP and completion plugins
- `lua/plugins/navigation.lua` - File navigation and search
- `lua/plugins/ui.lua` - UI/UX enhancements
- `lua/plugins/ai.lua` - AI-powered tools

### Language-Specific Settings

- TypeScript/JavaScript: `lua/plugins/lsp/settings/typescript.lua`
- Lua: `lua/plugins/lsp/settings/lua.lua`
- Other languages: Follow the same pattern

## Performance Guidelines

- Use lazy loading for plugins that don't need to start immediately
- Prefer `event` over `cmd` for triggering plugin loads
- Disable unused built-in plugins in `options.lua`
- Use `ft = { 'filetype' }` for filetype-specific plugins

## Testing Guidelines

- Write tests for utility functions in `lua/config/utils.lua`
- Use the configured Neotest setup with Vitest
- Test key mappings by verifying command execution
- Test plugin configurations by checking setup calls

## Common Patterns

### Conditional Loading

```lua
if vim.fn.executable('command') == 1 then
  return { "plugin/repo" }
end
```

### Buffer-Local Setup

```lua
local function setup_buffer(client, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
end
```

### Autocommand Groups

```lua
local group = vim.api.nvim_create_augroup("MyGroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "javascript", "typescript" },
  callback = function()
    -- Filetype-specific setup
  end,
})
```

## Notes for Agents

- This config targets Neovim 0.11+
- Uses modern LSP APIs and features
- Prioritizes web development (TypeScript/JavaScript)
- Maintains backward compatibility where possible
- Values performance and startup speed
- Uses transparent themes and custom highlights

