return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format({ async = true, lsp_format = 'fallback' }, function(err, did_edit)
          if not err and did_edit then
            vim.notify('Code formatted', vim.log.levels.INFO, { title = 'Conform' })
          end
        end)
      end,
      mode = { 'n', 'v' },
      desc = 'Format buffer',
    },
  },
  opts = {
    formatters_by_ft = {
      -- Go
      go = { 'goimports', 'gofmt' },

      -- Lua
      lua = { 'stylua' },

      -- Web technologies
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      javascriptreact = { 'prettier' },
      typescriptreact = { 'prettier' },
      json = { 'prettier' },
      jsonc = { 'prettier' },
      yaml = { 'prettier' },
      markdown = { 'prettier' },
      html = { 'prettier' },
      css = { 'prettier' },
      scss = { 'prettier' },
      toml = { 'taplo' },

      -- Python
      python = { 'isort', 'ruff' },

      -- Shell
      sh = { 'shfmt' },
      bash = { 'shfmt' },

      -- Other (system tools)
      rust = { 'rustfmt', lsp_format = 'fallback' }, -- comes with Rust installation

      -- Additional file types (uncomment as needed)
      -- markdown = { "markdownlint" },
      -- yaml = { "yamllint" },
    },
    default_format_opts = {
      lsp_format = 'fallback',
    },

    format_on_save = {
      timeout_ms = 1000,
      lsp_format = 'fallback',
    },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
