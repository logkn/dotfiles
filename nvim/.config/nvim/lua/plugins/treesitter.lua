local parsers = {
  'bash',
  'blade',
  'c',
  'go',
  'gomod',
  'gosum',
  'gowork',
  'html',
  'javascript',
  'json',
  'latex',
  'lua',
  'luadoc',
  'luap',
  'markdown',
  'markdown_inline',
  'php',
  'proto',
  'python',
  'query',
  'regex',
  'rust',
  'terraform',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'vue',
  'yaml',
  'zig',
}

local function install_parsers()
  require('nvim-treesitter').install(parsers, { summary = true })
end

local function setup_textobjects()
  require('nvim-treesitter-textobjects').setup {
    select = {
      lookahead = true,
      selection_modes = {
        ['@parameter.outer'] = 'v',
        ['@parameter.inner'] = 'v',
        ['@function.outer'] = 'v',
        ['@conditional.outer'] = 'V',
        ['@loop.outer'] = 'V',
        ['@class.outer'] = '<c-v>',
      },
      include_surrounding_whitespace = false,
    },
    move = {
      set_jumps = true,
    },
  }

  local select = require 'nvim-treesitter-textobjects.select'
  local move = require 'nvim-treesitter-textobjects.move'
  local mode_xo = { 'x', 'o' }
  local mode_nxo = { 'n', 'x', 'o' }

  vim.keymap.set(mode_xo, 'af', function()
    select.select_textobject('@function.outer', 'textobjects')
  end, { desc = 'around a function' })
  vim.keymap.set(mode_xo, 'if', function()
    select.select_textobject('@function.inner', 'textobjects')
  end, { desc = 'inner part of a function' })
  vim.keymap.set(mode_xo, 'ac', function()
    select.select_textobject('@class.outer', 'textobjects')
  end, { desc = 'around a class' })
  vim.keymap.set(mode_xo, 'ic', function()
    select.select_textobject('@class.inner', 'textobjects')
  end, { desc = 'inner part of a class' })
  vim.keymap.set(mode_xo, 'ai', function()
    select.select_textobject('@conditional.outer', 'textobjects')
  end, { desc = 'around an if statement' })
  vim.keymap.set(mode_xo, 'ii', function()
    select.select_textobject('@conditional.inner', 'textobjects')
  end, { desc = 'inner part of an if statement' })
  vim.keymap.set(mode_xo, 'al', function()
    select.select_textobject('@loop.outer', 'textobjects')
  end, { desc = 'around a loop' })
  vim.keymap.set(mode_xo, 'il', function()
    select.select_textobject('@loop.inner', 'textobjects')
  end, { desc = 'inner part of a loop' })
  vim.keymap.set(mode_xo, 'ap', function()
    select.select_textobject('@parameter.outer', 'textobjects')
  end, { desc = 'around parameter' })
  vim.keymap.set(mode_xo, 'ip', function()
    select.select_textobject('@parameter.inner', 'textobjects')
  end, { desc = 'inside a parameter' })

  vim.keymap.set(mode_nxo, '[f', function()
    move.goto_previous_start('@function.outer', 'textobjects')
  end, { desc = 'Previous function start' })
  vim.keymap.set(mode_nxo, '[c', function()
    move.goto_previous_start('@class.outer', 'textobjects')
  end, { desc = 'Previous class start' })
  vim.keymap.set(mode_nxo, '[p', function()
    move.goto_previous_start('@parameter.inner', 'textobjects')
  end, { desc = 'Previous parameter start' })
  vim.keymap.set(mode_nxo, ']F', function()
    move.goto_next_end('@function.outer', 'textobjects')
  end, { desc = 'Next function end' })
  vim.keymap.set(mode_nxo, ']C', function()
    move.goto_next_end('@class.outer', 'textobjects')
  end, { desc = 'Next class end' })
  vim.keymap.set(mode_nxo, ']P', function()
    move.goto_next_end('@parameter.inner', 'textobjects')
  end, { desc = 'Next parameter end' })
  vim.keymap.set(mode_nxo, ']f', function()
    move.goto_next_start('@function.outer', 'textobjects')
  end, { desc = 'Next function start' })
  vim.keymap.set(mode_nxo, ']c', function()
    move.goto_next_start('@class.outer', 'textobjects')
  end, { desc = 'Next class start' })
  vim.keymap.set(mode_nxo, ']p', function()
    move.goto_next_start('@parameter.inner', 'textobjects')
  end, { desc = 'Next parameter start' })
  vim.keymap.set(mode_nxo, '[F', function()
    move.goto_previous_end('@function.outer', 'textobjects')
  end, { desc = 'Previous function end' })
  vim.keymap.set(mode_nxo, '[C', function()
    move.goto_previous_end('@class.outer', 'textobjects')
  end, { desc = 'Previous class end' })
  vim.keymap.set(mode_nxo, '[P', function()
    move.goto_previous_end('@parameter.inner', 'textobjects')
  end, { desc = 'Previous parameter end' })
end

local function setup_treesitter()
  require('nvim-treesitter').setup {
    install_dir = vim.fn.stdpath 'data' .. '/site',
  }

  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('treesitter-main', { clear = true }),
    callback = function(args)
      local bufnr = args.buf

      if pcall(vim.treesitter.start, bufnr) then
        vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end,
  })

  install_parsers()
  setup_textobjects()
end

return {
  'nvim-treesitter/nvim-treesitter',
  main = 'nvim-treesitter',
  build = ':TSUpdate',
  branch = 'main',
  lazy = false,
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
  },
  config = setup_treesitter,
}
