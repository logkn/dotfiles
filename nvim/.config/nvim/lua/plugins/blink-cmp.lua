return {
  "saghen/blink.cmp",
  enabled = true,
  opts = {
    keymap = {
      preset = "default",
      -- "<C-c>" shows copilot suggestions
      ["<C-c>"] = {
        function(cmp)
          cmp.show({ providers = { "supermaven" } })
        end,
      },
    },
  },
}
