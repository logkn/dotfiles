return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  requires = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({})

    vim.api.nvim_set_hl(0, "NvimTreeNormal", { guibg = NONE, ctermbg = NONE })
    vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { guibg = NONE, ctermbg = NONE })
  end,
}
