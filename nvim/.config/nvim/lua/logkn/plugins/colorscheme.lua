local colors = {
  rose_pine = {
    "rose-pine/neovim",
    name = "rose-pine",
    colorscheme_name = "rose-pine-moon",
    opts = {
      styles = {
        bold = true,
        italic = true,
        transparency = false,
      },
      groups = {},
      dim_inactive_windows = false,
      extend_background_behind_borders = true,
    },
  },

  kanagawa = {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    colorscheme_name = "kanagawa-wave",
    opts = {
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
    },
  },
}

local function load_color(color)
  return {
    color[1],
    name = color.name,
    priority = color.priority or 1000,
    init = color.init or function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      vim.cmd.colorscheme(color.colorscheme_name)

      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

      -- You can configure highlights by doing something like:
      -- vim.cmd.hi("Comment gui=none")
    end,
    opts = color.opts,
  }
end

local current_color = colors.kanagawa

return load_color(current_color)
