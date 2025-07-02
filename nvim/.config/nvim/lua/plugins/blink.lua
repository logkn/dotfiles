return {
  'saghen/blink.cmp',
  build = 'cargo +nightly build --release',
  dependencies = {
    'rafamadriz/friendly-snippets',
    -- add blink.compat to dependencies
    {
      'saghen/blink.compat',
      opts = {},
    },
    {
      'huijiro/blink-cmp-supermaven',
    },
    {
      'supermaven-inc/supermaven-nvim',
      -- keys = {
      --   -- {
      --   --   '<leader>tc',
      --   --   '<cmd>SupermavenToggle<cr>',
      --   --   desc = '[T]oggle [C]opilot',
      --   -- },
      -- },
      opts = {
        disable_inline_completion = true,
        disable_keymaps = true,
      },
    },
  },
  opts = {
    sources = {
      default = { 'lsp', 'path', 'supermaven', 'snippets', 'buffer' },
      providers = {
        supermaven = {
          name = 'supermaven',
          module = 'blink-cmp-supermaven',
          async = true,
        },
      },
    },
    keymap = {
      preset = 'default',
      -- "<C-c>" shows copilot suggestions
      ['<C-c>'] = {
        function(cmp)
          cmp.show { providers = { 'supermaven' } }
        end,
      },
      ['<C-y>'] = { 'select_and_accept' },
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
    },
  },
}
