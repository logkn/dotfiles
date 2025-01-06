return {
  "neovim/nvim-lspconfig",
  opts = function()
    ---@class PluginLspOpts
    local ret = {
      inlay_hints = {
        enabled = false,
      },
    }
  end,
}
