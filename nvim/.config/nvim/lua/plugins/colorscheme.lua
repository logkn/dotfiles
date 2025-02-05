return {
  -- add gruvbox
  {
    "logkn/gruvbox-material",
    version = false,
    lazy = false,
    priority = 1000,
    -- opts = { float = { background_color = require("gruvbox-material.colors").get(vim.o.background, "medium").bg0 } },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
    },
  },
}
