return {
  "saghen/blink.cmp",
  version = "*",
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

      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-l>"] = { "snippet_forward", "fallback" },
      ["<C-h>"] = { "snippet_backward", "fallback" },
    },
  },
}
