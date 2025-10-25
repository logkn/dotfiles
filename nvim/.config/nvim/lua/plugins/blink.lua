return {
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    -- dependencies = { 'rafamadriz/friendly-snippets', 'supermaven-inc/supermaven-nvim', 'huijiro/blink-cmp-supermaven' },
    dependencies = { 'rafamadriz/friendly-snippets', 'fang2hou/blink-copilot' },

    -- use a release tag to download pre-built binaries
    version = '1.*',

    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      --
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = 'default',
        -- ['<C-c>'] = {
        --   function(cmp)
        --     cmp.show { providers = { 'supermaven' } }
        --   end,
        -- },
        ['<Tab>'] = {
          'snippet_forward',
          function() -- sidekick next edit suggestion
            return require('sidekick').nes_jump_or_apply()
          end,
          function() -- if you are using Neovim's native inline completions
            return vim.lsp.inline_completion.get()
          end,
          'fallback',
        },
      },
      cmdline = {
        enabled = true,
        keymap = {
          preset = 'cmdline',
          ['<Right>'] = false,
          ['<Left>'] = false,
        },
        completion = {
          list = { selection = { preselect = false } },
          menu = {
            auto_show = function(ctx)
              return vim.fn.getcmdtype() == ':'
            end,
          },
          ghost_text = { enabled = true },
        },
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono',
      },

      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        accept = { auto_brackets = { enabled = true } },
        ghost_text = { enabled = false },

        menu = {
          draw = {
            treesitter = { 'lsp' },
          },
        },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },

        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 100,
            -- async = true,
          },
        },
        compat = {},
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = 'rust' },
    },
    opts_extend = { 'sources.default' },
  },

  {
    'saghen/blink.cmp',
    opts = function(_, opts)
      local icons = require 'config.icons'
      opts.appearance = opts.appearance or {}
      opts.appearance.kind_icons = vim.tbl_extend('force', opts.appearance.kind_icons or {}, icons.kinds)
    end,
  },
}
