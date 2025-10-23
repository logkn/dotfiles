---@brief
---
--- https://pyrefly.org/
---
---`pyrefly`, a faster Python type checker written in Rust.
--
-- `pyrefly` is still in development, so please report any errors to
-- our issues page at https://github.com/facebook/pyrefly/issues.

local blink = require 'blink.cmp'
return {
  cmd = { 'pyrefly', 'lsp' },
  filetypes = { 'python' },
  root_markers = {
    'pyrefly.toml',
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git',
  },

  capabilities = vim.tbl_deep_extend('force', {}, vim.lsp.protocol.make_client_capabilities(), blink.get_lsp_capabilities(), {
    fileOperations = {
      didRename = true,
      willRename = true,
    },
  }),
}
