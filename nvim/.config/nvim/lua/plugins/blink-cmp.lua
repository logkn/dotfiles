return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "default",

      -- disable <C-space>
      ["<C-space>"] = {},

      -- use <C-b> to prompt completion
      ["<C-b>"] = {
        function(cmp)
          cmp.show()
        end,
      },

      -- use <C-c> to prompt Copilot completion
      ["<C-c>"] = {
        function(cmp)
          cmp.show({ providers = { "copilot" } })
        end,
      },
    },
  },
}
-- return {
--   "saghen/blink.cmp",
--   -- optional: provides snippets for the snippet source
--   dependencies = { "rafamadriz/friendly-snippets", "giuxtaposition/blink-cmp-copilot" },
--
--   -- use a release tag to download pre-built binaries
--   version = "*",
--   -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
--   -- build = 'cargo build --release',
--   -- If you use nix, you can build from source using latest nightly rust with:
--   -- build = 'nix run .#build-plugin',
--
--   completion = {
--     ghost_text = { enabled = true },
--     menu = {
--       auto_show = false,
--     },
--   },
--
--   ---@module 'blink.cmp'
--   ---@type blink.cmp.Config
--   opts = {
--     -- 'default' for mappings similar to built-in completion
--     -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
--     -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
--     -- See the full "keymap" documentation for information on defining your own keymap.
--     keymap = {
--       preset = "default",
--
--       -- disable <C-space>
--       ["<C-space>"] = {},
--
--       -- use <C-b> to prompt completion
--       ["<C-b>"] = {
--         function(cmp)
--           cmp.show()
--         end,
--       },
--
--       -- use <C-c> to prompt Copilot completion
--       ["<C-c>"] = {
--         function(cmp)
--           cmp.show({ providers = { "copilot" } })
--         end,
--       },
--     },
--
--     appearance = {
--       -- Sets the fallback highlight groups to nvim-cmp's highlight groups
--       -- Useful for when your theme doesn't support blink.cmp
--       -- Will be removed in a future release
--       use_nvim_cmp_as_default = true,
--       -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
--       -- Adjusts spacing to ensure icons are aligned
--       nerd_font_variant = "mono",
--     },
--
--     -- Default list of enabled providers defined so that you can extend it
--     -- elsewhere in your config, without redefining it, due to `opts_extend`
--     sources = {
--       default = { "lsp", "path", "snippets", "buffer", "copilot" },
--       providers = {
--         copilot = {
--           name = "copilot",
--           module = "blink-cmp-copilot",
--           score_offset = 100,
--           async = true,
--         },
--       },
--     },
--   },
--   opts_extend = { "sources.default" },
-- }