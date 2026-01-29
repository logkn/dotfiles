-- ---@type vim.lsp.Config
-- return {
--   cmd = { 'marksman', 'server' },
--   filetypes = { 'markdown', 'markdown.mdx' },
--   root_markers = { '.marksman.toml', '.git' },
-- }

local blink = require 'blink.cmp'

return {
  cmd = { 'marksman', 'server' },
  filetypes = { 'markdown', 'markdown.mdx' },
  root_markers = { '.marksman.toml', '.git' },
  capabilities = vim.tbl_deep_extend('force', {}, vim.lsp.protocol.make_client_capabilities(), blink.get_lsp_capabilities()),
}
