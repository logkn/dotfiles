return {
  {
    'williamboman/mason.nvim',
    lazy = false, -- Load immediately to ensure PATH is set
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
    build = ':MasonUpdate',
    opts = {
      ensure_installed = {
        -- LSP servers (matching your vim.lsp.enable() config)
        -- Python
        'ruff',
        'ty',
        -- 'basedpyright', # this one is too bulky
        'pyrefly',
        -- Lua
        'lua-language-server',
        'stylua',
        'luacheck',
        -- Go
        -- Note: gofmt comes with Go installation, not managed by Mason
        'gopls',
        'goimports',
        'golangci-lint',
        'delve', -- debugger
        -- TypeScript
        'prettier',
        'typescript-language-server', -- TypeScript LSP
        -- Rust
        'rust-analyzer',
        -- CSS & HTML
        'tailwindcss-language-server', -- Tailwind CSS LSP
        'css-lsp', -- CSS LSP
        'html-lsp', -- HTML LSP
        -- Shell
        'shfmt', -- Shell formatter
        'shellcheck', -- Shell linter

        -- Linters and diagnostics
        'eslint_d',

        -- Static Files
        'markdownlint', -- Markdown linting
        'marksman', -- Markdown LSP, with linking (like Obsidian)
        'yamllint', -- YAML linting
        'jsonlint', -- JSON linting
        'taplo', -- TOML formatter/LSP

        -- AI
        'copilot-language-server',
      },
    },
    config = function(_, opts)
      -- PATH is handled by core.mason-path for consistency
      require('mason').setup(opts)

      -- Auto-install ensure_installed tools with better error handling
      local mr = require 'mason-registry'
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          if mr.has_package(tool) then
            local p = mr.get_package(tool)
            if not p:is_installed() then
              vim.notify('Mason: Installing ' .. tool .. '...', vim.log.levels.INFO)
              p:install():once('closed', function()
                if p:is_installed() then
                  vim.notify('Mason: Successfully installed ' .. tool, vim.log.levels.INFO)
                else
                  vim.notify('Mason: Failed to install ' .. tool, vim.log.levels.ERROR)
                end
              end)
            end
          else
            vim.notify("Mason: Package '" .. tool .. "' not found", vim.log.levels.WARN)
          end
        end
      end

      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
}
