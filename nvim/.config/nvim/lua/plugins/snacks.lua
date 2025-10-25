local pokemon = 'ho-oh'

local function make_lsp_goto(method, picker_fn, label)
  return function()
    local clients = vim.lsp.get_clients { bufnr = 0 }
    if #clients == 0 then
      vim.notify(('No LSP clients available for %s'):format(label or method), vim.log.levels.WARN)
      return
    end

    local params = vim.lsp.util.make_position_params(0, clients[1].offset_encoding or 'utf-16')

    vim.lsp.buf_request_all(0, method, params, function(responses)
      local locations = {}

      for client_id, response in pairs(responses) do
        local result = response.result
        if result then
          local client = vim.lsp.get_client_by_id(client_id)
          local encoding = client and client.offset_encoding or 'utf-16'
          if not vim.islist(result) then
            result = { result }
          end

          for _, location in ipairs(result) do
            locations[#locations + 1] = { location = location, encoding = encoding }
          end
        end
      end

      if #locations == 1 then
        local entry = locations[1]
        vim.schedule(function()
          vim.lsp.util.show_document(entry.location, entry.encoding, { reuse_win = true, focus = true })
        end)
        return
      end

      if #locations == 0 then
        vim.schedule(function()
          vim.notify(('No %s found'):format(label or 'locations'), vim.log.levels.INFO)
        end)
        return
      end

      vim.schedule(picker_fn)
    end)
  end
end

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  dependencies = {
    'echasnovski/mini.icons',
    'nvim-tree/nvim-web-devicons',
  },

  ---@module "snacks"
  keys = {
    {
      '<leader>z',
      function()
        Snacks.zen()
      end,
      desc = 'Toggle [Z]en Mode',
    },
    {
      '<leader>un',
      function()
        Snacks.notifier.hide()
      end,
      desc = 'Dismiss All Notifications',
    },
    {
      '<leader>bd',
      function()
        Snacks.bufdelete()
      end,
      desc = 'Delete Buffer',
    },

    {
      '<leader>bo',
      function()
        Snacks.bufdelete.other()
      end,
      desc = 'Delete [O]ther Buffer',
    },
    -- Git
    {
      '<leader>gb',
      function()
        Snacks.git.blame_line()
      end,
      desc = 'Git Blame Line',
    },
    {
      '<leader>gB',
      function()
        Snacks.gitbrowse()
      end,
      desc = 'Git Browse',
    },
    -- Terminal
    {
      '<c-/>',
      function()
        Snacks.terminal()
      end,
      desc = 'Toggle Terminal',
    },
    {
      '<c-_>',
      function()
        Snacks.terminal()
      end,
      desc = 'which_key_ignore',
    },
    -- Words
    {
      ']]',
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = 'Next Reference',
      mode = { 'n', 't' },
    },
    {
      '[[',
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = 'Prev Reference',
      mode = { 'n', 't' },
    },
    -- Picker
    {
      '<leader>sf',
      function()
        Snacks.picker.files {
          finder = 'files',
          format = 'file',
          show_empty = true,
          supports_live = true,
        }
      end,
      desc = '[S]earch Files',
    },
    {
      '<leader>sg',
      function()
        Snacks.picker.grep {
          live = false,
          show_empty = true,
          regex = false,
          need_search = false,
        }
      end,
      desc = '[S]earch [G]rep',
    },
    {
      '<leader>ga',
      function()
        Snacks.picker.grep_word()
      end,
      desc = 'Visual selection or word',
      mode = { 'n', 'x' },
    },
    {
      '<leader>sb',
      function()
        Snacks.picker.buffers()
      end,
      desc = '[S]earch [B]uffers',
    },
    {
      '<leader><space>',
      function()
        Snacks.picker.smart()
      end,
      desc = 'Smart Open',
    },
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = '[S]earch [K]eymaps',
    },
    {
      '<leader>ss',
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = '[S]earch [S]ymbols (buffer)',
    },
    {
      '<leader>sS',
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = '[S]earch [S]ymbols (workspace)',
    },
    {
      'gd',
      make_lsp_goto('textDocument/definition', function()
        Snacks.picker.lsp_definitions()
      end, 'definitions'),
      desc = '[G]oto [D]efinition',
    },
    {
      'gy',
      make_lsp_goto('textDocument/typeDefinition', function()
        Snacks.picker.lsp_type_definitions()
      end, 'type definitions'),
      desc = '[G]oto T[y]pe [D]efinition',
    },
    {
      'gr',
      function()
        Snacks.picker.lsp_references()
      end,
      desc = '[G]oto [R]eferences',
    },
    {
      '<leader>.',
      function()
        Snacks.scratch()
      end,
      desc = 'Toggle Scratch Buffer',
    },
    {
      '<leader>S',
      function()
        Snacks.scratch.select()
      end,
      desc = 'Select Scratch Buffer',
    },
    {
      '<leader>e',
      function()
        Snacks.explorer.open()
      end,
      desc = 'Toggle [E]xplorer',
    },
  },

  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    indent = { enabled = true },
    notify = { enabled = true },
    image = { enabled = true },
    gitbrowse = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = [[

██╗  ██╗██╗   ██╗██████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
██║  ██║╚██╗ ██╔╝██╔══██╗██╔══██╗██║   ██║██║████╗ ████║
███████║ ╚████╔╝ ██████╔╝██████╔╝██║   ██║██║██╔████╔██║
██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══██╗╚██╗ ██╔╝██║██║╚██╔╝██║
██║  ██║   ██║   ██║     ██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      },
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        { section = 'startup' },
        {
          section = 'terminal',
          cmd = string.format('pokemon-colorscripts --no-title -n %s; sleep .1', pokemon),
          random = 10,
          pane = 2,
          indent = 4,
          height = 30,
        },
      },
    },
    input = {
      enabled = true,
    },
    styles = {
      notification = {
        wo = { wrap = true }, -- Wrap notifications
      },
    },
    picker = {
      matcher = {
        frecency = true,
        fuzzy = true,
        smartcase = true,
        ignorecase = true,
        history_bonus = true,
        show_empty = true,
      },
      win = {
        input = {
          keys = {
            -- to close the picker on ESC instead of going to normal mode,
            -- add the following keymap to your config
            -- ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
          },
        },
      },
      ui_select = true,
      sources = {
        ---@class snacks.picker.explorer.Config
        explorer = {
          actions = {
            copy_relative_path = {
              action = function(_, item)
                if not item then
                  return
                end

                local relative_path = vim.fn.fnamemodify(item.file, ':.')
                vim.fn.setreg('+', relative_path)
                Snacks.notify.info('Yanked `' .. relative_path .. '`')
              end,
            },
            copy_name = {
              action = function(_, item)
                if not item then
                  return
                end

                local file_name = vim.fn.fnamemodify(item.file, ':t')
                vim.fn.setreg('+', file_name)
                Snacks.notify.info('Yanked `' .. file_name .. '`')
              end,
            },
          },
          follow_file = true,
          win = {
            list = {
              keys = {
                ['y'] = { 'copy_name', mode = { 'n', 'x' } },
                ['Y'] = { 'copy_relative_path', mode = { 'n', 'x' } },
              },
            },
          },
        },
      },
    },
    ---@class snacks.explorer.Config
    explorer = { enabled = true, replace_netrw = true },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>ts'
        Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>tw'
        Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>trl'
        Snacks.toggle.diagnostics():map '<leader>td'
        Snacks.toggle.line_number():map '<leader>tl'
        Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>uc'
        Snacks.toggle.treesitter():map '<leader>tT'
        -- Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
        Snacks.toggle.inlay_hints():map '<leader>th'
      end,
    })
  end,
}
