return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  branch = 'main',
  version = false, -- last release is way too old and doesn't work on Windows
  lazy = false,
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
  },
  opts = {
    sync_install = false,
    ignore_install = { 'javascript' },
    modules = {},
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },

    folds = { enable = true },
    auto_install = true,
    ensure_installed = {
      'bash',
      'c',
      'html',
      'javascript',
      'json',
      'lua',
      'luadoc',
      'luap',
      'markdown',
      'markdown_inline',
      'python',
      'query',
      'regex',
      'tsx',
      'typescript',
      'vue',
      'vim',
      'vimdoc',
      'yaml',
      'rust',
      'go',
      'gomod',
      'gowork',
      'gosum',
      'terraform',
      'proto',
      'zig',
      'php',
      'blade',
      'latex',
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<leader>vv',
        node_incremental = '+',
        scope_incremental = false,
        node_decremental = '_',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['af'] = { query = '@function.outer', desc = 'around a function' },
          ['if'] = { query = '@function.inner', desc = 'inner part of a function' },
          ['ac'] = { query = '@class.outer', desc = 'around a class' },
          ['ic'] = { query = '@class.inner', desc = 'inner part of a class' },
          ['ai'] = { query = '@conditional.outer', desc = 'around an if statement' },
          ['ii'] = { query = '@conditional.inner', desc = 'inner part of an if statement' },
          ['al'] = { query = '@loop.outer', desc = 'around a loop' },
          ['il'] = { query = '@loop.inner', desc = 'inner part of a loop' },
          ['ap'] = { query = '@parameter.outer', desc = 'around parameter' },
          ['ip'] = { query = '@parameter.inner', desc = 'inside a parameter' },
        },
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          ['@parameter.inner'] = 'v', -- charwise
          ['@function.outer'] = 'v', -- charwise
          ['@conditional.outer'] = 'V', -- linewise
          ['@loop.outer'] = 'V', -- linewise
          ['@class.outer'] = '<c-v>', -- blockwise
        },
        include_surrounding_whitespace = false,
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_previous_start = {
          ['[f'] = { query = '@function.outer', desc = 'Previous (f)unction start' },
          ['[c'] = { query = '@class.outer', desc = 'Previous (c)lass start' },
          ['[p'] = { query = '@parameter.inner', desc = 'Previous (p)arameter start' },
        },
        goto_next_end = {
          [']F'] = { query = '@function.outer', desc = 'Next (f)unction end' },
          [']C'] = { query = '@class.outer', desc = 'Next (c)lass end' },
          [']P'] = { query = '@parameter.inner', desc = 'Next (p)arameter end' },
        },
        goto_next_start = {
          [']f'] = { query = '@function.outer', desc = 'Next (f)unction start' },
          [']c'] = { query = '@class.outer', desc = 'Next (c)lass start' },
          [']p'] = { query = '@parameter.inner', desc = 'Next (p)arameter start' },
        },
        goto_previous_end = {
          ['[F'] = { query = '@function.outer', desc = 'Previous (f)unction end' },
          ['[C'] = { query = '@class.outer', desc = 'Previous (c)lass end' },
          ['[P'] = { query = '@parameter.inner', desc = 'Previous (p)arameter end' },
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  },
}
