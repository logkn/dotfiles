return {
  {
    'logkn/gruvbox-material',
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },
}
