# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Neovim configuration based on LazyVim. The repository structure follows the standard LazyVim configuration pattern with custom plugins and LSP configurations.

## Common Commands

### Formatting
- `stylua .` - Format Lua code (uses stylua.toml configuration)

### Plugin Management  
- Open Neovim and let lazy.nvim automatically install/update plugins
- Plugins are automatically checked for updates (configured in lua/config/lazy.lua)

### Linting
The project includes stylua configuration for Lua formatting:
- 2 spaces indentation
- 120 character column width

## Architecture

### Entry Point
- `init.lua` bootstraps the lazy.nvim configuration

### Main Configuration
- `lua/config/` - Core LazyVim configuration files
  - `lazy.lua` - Bootstraps lazy.nvim and loads LSP servers
  - `options.lua` - Sets Neovim options and LazyVim preferences
  - `keymaps.lua` - Custom keybindings
  - `autocmds.lua` - Autocommands

### Plugin Configurations  
- `lua/plugins/` - Each file defines a plugin or group of related plugins
- Plugins use lazy.nvim's structured format with module returns

### LSP Configurations
- `lsp/` - Individual LSP server configurations
- Servers are enabled in `lua/config/lazy.lua` via `vim.lsp.enable()`

### LazyVim Configuration
- `lazyvim.json` - Declares LazyVim extras to include
- Uses LazyVim's modular extra system for AI (Copilot), debugging, and utilities

## Key Customizations

- Uses `blink.cmp` for completion (`g.lazyvim_cmp = "blink.cmp"`)
- Uses `snacks` picker (`g.lazyvim_picker = "snacks"`)
- Custom colorscheme: gruvbox-material
- LSP servers: basedpyright, gopls, jsonls, lua_ls, tailwindcss, tsserver, yamlls
- Disabled animations (`g.snacks_animate = false`)