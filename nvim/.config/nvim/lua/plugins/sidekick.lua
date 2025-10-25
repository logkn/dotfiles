return {
  {
    'folke/sidekick.nvim',
    opts = {
      -- add any options here
      cli = {
        mux = {
          backend = 'tmux',
          enabled = true,
        },
      },
    },
    keys = {
      {
        '<c-.>',
        function()
          require('sidekick.cli').toggle {
            name = 'codex',
            focus = true,
          }
        end,
        desc = 'Sidekick Toggle',
        mode = { 'n', 't', 'i', 'x' },
      },
      {
        '<tab>',
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require('sidekick').nes_jump_or_apply() then
            return '<Tab>' -- fallback to normal tab
          end
        end,
        expr = true,
        desc = 'Goto/Apply Next Edit Suggestion',
      },
      -- {
      --   '<leader>aa',
      --   function()
      --     require('sidekick.cli').toggle()
      --   end,
      --   desc = 'Sidekick Toggle CLI',
      -- },
      {
        '<leader>as',
        function()
          require('sidekick.cli').select()
        end,
        -- Or to select only installed tools:
        -- require("sidekick.cli").select({ filter = { installed = true } })
        desc = 'Select CLI',
      },
      {
        '<leader>ad',
        function()
          require('sidekick.cli').close()
        end,
        desc = 'Detach a CLI Session',
      },
      {
        '<leader>at',
        function()
          require('sidekick.cli').send { msg = '{this}' }
        end,
        mode = { 'x', 'n' },
        desc = 'Send This',
      },
      {
        '<leader>af',
        function()
          require('sidekick.cli').send { msg = '{file}' }
        end,
        desc = 'Send File',
      },
      {
        '<leader>av',
        function()
          require('sidekick.cli').send { msg = '{selection}' }
        end,
        mode = { 'x' },
        desc = 'Send Visual Selection',
      },
      {
        '<leader>ap',
        function()
          require('sidekick.cli').prompt()
        end,
        mode = { 'n', 'x' },
        desc = 'Sidekick Select Prompt',
      },
      -- Example of a keybinding to open Claude directly
      {
        '<leader>ac',
        function()
          require('sidekick.cli').toggle { name = 'claude', focus = true }
        end,
        desc = 'Sidekick Toggle Claude',
      },
    },
  },

  {
    'nvim-lualine/lualine.nvim',
    opts = function(_, opts)
      opts.sections = opts.sections or {}
      opts.sections.lualine_c = opts.sections.lualine_c or {}

      -- Copilot status
      table.insert(opts.sections.lualine_c, {
        function()
          return ' '
        end,
        color = function()
          local status = require('sidekick.status').get()
          if status then
            return status.kind == 'Error' and 'DiagnosticError' or status.busy and 'DiagnosticWarn' or 'Special'
          end
        end,
        cond = function()
          local status = require 'sidekick.status'
          return status.get() ~= nil
        end,
      })

      -- CLI session status
      table.insert(opts.sections.lualine_x, 2, {
        function()
          local status = require('sidekick.status').cli()
          return ' ' .. (#status > 1 and #status or '')
        end,
        cond = function()
          return #require('sidekick.status').cli() > 0
        end,
        color = function()
          return 'Special'
        end,
      })
    end,
  },

  {
    'folke/snacks.nvim',
    optional = true,
    opts = {
      picker = {
        actions = {
          sidekick_send = function(...)
            return require('sidekick.cli.picker.snacks').send(...)
          end,
        },
        win = {
          input = {
            keys = {
              ['<a-a>'] = {
                'sidekick_send',
                mode = { 'n', 'i' },
              },
            },
          },
        },
      },
    },
  },
}
