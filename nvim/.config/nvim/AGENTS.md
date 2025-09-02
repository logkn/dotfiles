# Repository Guidelines

## Project Structure & Module Organization
- `init.lua`: Entry point loading config, core, and autocommands.
- `lua/core/`: Bootstrap and globals (e.g., `lazy.lua`, `lsp.lua`, PATH setup).
- `lua/config/`: Options, keymaps, autocmds; keep user-facing tweaks here.
- `lua/plugins/`: One file per plugin spec for lazy.nvim (kebab-case filenames).
- `lsp/`: Per-server settings exported as Lua tables (e.g., `lua_ls.lua`).
- `doc/`: Help/docs. `lazy-lock.json`: plugin lockfile (do not edit manually).

## Build, Test, and Development Commands
- Launch Neovim: `nvim` (this config loads automatically here).
- Manage plugins: `:Lazy sync` (install/update), `:Lazy check` (health), `:Lazy clean` (remove unused), `:Lazy profile` (perf).
- LSP/tooling: `:Mason` (UI), `:MasonUpdate`, `:LspInfo`, `:LspRestart`, `:LspDiagnostics`.
- Format Lua: `stylua .` (uses `.stylua.toml`). Example CI/local check: `stylua --check .`.
- Health checks: `:checkhealth` (verify providers, treesitter, etc.).

## Coding Style & Naming Conventions
- Lua formatting: stylua, 2-space indent, single quotes preferred, no extra parentheses (per `.stylua.toml`).
- Module layout: keep plugin-specific config in `lua/plugins/<feature>.lua`; general editor behavior in `lua/config/*`.
- LSP: enable servers in `lua/core/lsp.lua`; add per-server files to `lsp/` that `return { ... }`.
- Filenames: kebab-case for plugin specs (e.g., `todo-comments.lua`).

## Testing Guidelines
- Sanity: `:checkhealth`, then `:Lazy sync` in a fresh session.
- LSP: open a relevant filetype and run `:LspInfo` and `:LspCapabilities`.
- Formatting: run `stylua --check .` before sending a PR.
- Manual smoke test keymaps in `lua/config/keymaps.lua` and UI surfaces (statusline, tree, telescope).

## Commit & Pull Request Guidelines
- Commits: Conventional style recommended.
  - Examples: `feat(plugins): add trouble.nvim`, `fix(lsp): correct lua_ls hints`, `chore(style): run stylua`.
- PRs: include summary, rationale, test steps, and screenshots for UI changes. Note any `lazy-lock.json` changes.
- Keep changes scoped; avoid unrelated refactors.

## Security & Configuration Tips
- Do not commit secrets or machine-specific paths. Keep `lazy-lock.json` committed to pin versions.
- Add new CLI tools to `lua/plugins/mason.lua` under `ensure_installed` to standardize dev environments.
