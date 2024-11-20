return {
  'stevearc/oil.nvim',
  enabled = false,
  opts = {
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
    },
    float = {
      -- Padding around the floating window
      padding = 2,
      max_width = 90,
      max_height = 0,
      -- border = "rounded",
      win_options = {
        winblend = 0,
      },
    },
  },
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
