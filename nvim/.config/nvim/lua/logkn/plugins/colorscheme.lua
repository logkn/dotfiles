return {
  'rose-pine/neovim',
  name = 'rose-pine',
  priority = 1000,

  init = function()
    -- Load the colorscheme here.
    -- Like many other themes, this one has different styles, and you could load
    vim.cmd.colorscheme 'rose-pine-moon'

    -- You can configure highlights by doing something like:
    -- vim.cmd.hi 'Comment gui=none'
  end,
  opts = {
    -- transparent_background = true,
    -- variant = 'moon',
  },
}
