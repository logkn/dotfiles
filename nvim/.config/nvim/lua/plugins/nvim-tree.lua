return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  enabled = false,
  requires = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    filters = {
      dotfiles = false,
      custom = {
        '*lock.json',
      },
      exclude = {},
    },
    git = {
      ignore = false,
    },
  },
  config = function(_, opts)
    require('nvim-tree').setup(opts)

    vim.api.nvim_set_hl(0, 'NvimTreeNormal', { guibg = nil, ctermbg = nil })
    vim.api.nvim_set_hl(0, 'NvimTreeEndOfBuffer', { guibg = nil, ctermbg = nil })
  end,
}
