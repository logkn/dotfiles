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
    cmdline = {
      enabled = true,
      keymap = {
        preset = "cmdline",
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
      },
      sources = function()
        local type = vim.fn.getcmdtype()
        -- Search forward and backward
        if type == "/" or type == "?" then
          return { "buffer" }
        end
        -- Commands
        if type == ":" or type == "@" then
          return { "cmdline" }
        end
        return {}
      end,
      completion = {
        trigger = {
          show_on_blocked_trigger_characters = {},
          show_on_x_blocked_trigger_characters = {},
        },
        list = {
          selection = {
            -- When `true`, will automatically select the first item in the completion list
            preselect = true,
            -- When `true`, inserts the completion item automatically when selecting it
            auto_insert = true,
          },
        },
        -- Whether to automatically show the window when new completion items are available
        menu = { auto_show = true },
        -- Displays a preview of the selected item on the current line
        ghost_text = { enabled = true },
      },
    },
  },
}
