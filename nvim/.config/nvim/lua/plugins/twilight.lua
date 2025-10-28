return {
  'folke/twilight.nvim',
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    dimming = {
      alpha = 0.4, -- amount of dimming
      -- we try to get the foreground from the highlight groups or fallback color
      -- we will use the "String" highlight group as the foreground on the current line
      -- other options: 'Normal', 'Comment', etc
      color = { 'Normal', '#ffffff' },
    },
  },
}
