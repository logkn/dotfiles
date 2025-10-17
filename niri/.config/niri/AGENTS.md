# Repository Guidelines

## Project Structure & Module Organization
This repository centers on `config.kdl`, the KDL-formatted configuration loaded by Niri. Use the existing top-level nodes (`input`, `output`, `layout`, etc.) as anchors when extending functionality. Group related tweaks under the node they affect, and keep experimental variants in adjacent commented blocks so reviewers can trace intent quickly.

## Build, Test, and Development Commands
- `niri validate`: run this immediately after editing to catch syntax or schema errors before reloading.
- `niri msg reload-config`: reloads the compositor with your changes; run it from an active Niri session to verify syntax quickly.
- `niri msg outputs`: prints the live output identifiers so you can cross-check new monitor rules before committing them.
- `journalctl --user-unit niri -f`: follow runtime logs to confirm that input, layout, or animation adjustments behave as expected.

## Coding Style & Naming Conventions
Indent child nodes with four spaces and align closing braces with their opener. Prefer lowercase identifiers for named nodes and quote strings that include symbols (`mode "3840x2160@119.88"`). Use `//` for inline commentary and `/-` blocks to temporarily disable configuration while keeping context in the file. Keep related numeric values (such as gaps or repeat rates) on their own lines and include brief comments only when the intent is non-obvious.

## Testing Guidelines
Run `niri validate` after every edit to ensure the config passes static checks before touching a live session. Validate structural changes by reloading the configuration and checking for warnings in the Niri log tail. For behavioral adjustments, exercise the affected devices or layouts immediately after reload. When adding new monitor rules, document the hardware you exercised and include before/after observations so reviewers can reproduce them. Flag any changes that require a compositor restart.

## Commit & Pull Request Guidelines
Favor focused commits that address a single configuration concern and describe both the change and its effect (e.g., "layout: tighten gaps for ultrawide workflow"). In pull requests, summarize the scenario you tested (`outputs`, inputs, and key bindings), reference any related discussions, and attach screenshots or recordings when the change affects visuals. Highlight follow-up ideas in a final checklist to capture future experiments without blocking the review.

## Security & Configuration Tips
Never commit hardware identifiers or seat names you have not verified locally. Treat secrets, such as VPN or portal environment variables, as out of scope for this repository. When unsure about downstream effects, add a commented fallback configuration so contributors can revert quickly during review.
