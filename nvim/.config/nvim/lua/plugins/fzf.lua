return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",
  opts = {},
  keys = {
    { "<leader>sh", "<cmd>FzfLua helptags<cr>", desc = "[S]earch [H]elp" },
    { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "[S]earch [K]eymaps" },
    { "<leader>sf", "<cmd>FzfLua files<cr>", desc = "[S]earch [F]iles" },
    { "<leader>sd", "<cmd>FzfLua diagnostics<cr>", desc = "[S]earch [D]iagnostics" },
    { "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "[S]earch by [G]rep" },
    { "<leader>sw", "<cmd>FzfLua grep_cword<cr>", desc = "[S]earch current [W]ord" },
    { "<leader>s.", "<cmd>FzfLua oldfiles<cr>", desc = '[S]earch Recent Files ("." for repeat)' },
    { "<leader><leader>", "<cmd>FzfLua buffers<cr>", desc = "[ ] Find existing buffers" },
  },
}
