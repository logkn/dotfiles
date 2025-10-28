return {
  'stevearc/oil.nvim',
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    default_file_explorer = false,
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
    columns = { 'icon' },
    keymaps = {
      ['<C-h>'] = false,
      ['<M-h>'] = 'actions.select_split',
    },
  },
  keys = {
    { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' },
    -- { "<leader>-", require("oil").toggle_float },
  },
}
