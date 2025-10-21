local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = augroup 'kickstart-highlight-yank',
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function(event)
    vim.schedule(function()
      require('noice.text.markdown').keys(event.buf)
    end)
  end,
})

-- Snacks + nvim-tree rename integration
local prev = { new_name = '', old_name = '' } -- Prevents duplicate events
vim.api.nvim_create_autocmd('User', {
  pattern = 'NvimTreeSetup',
  callback = function()
    local events = require('nvim-tree.api').events
    events.subscribe(events.Event.NodeRenamed, function(data)
      if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
        data = data
        Snacks.rename.on_rename_file(data.old_name, data.new_name)
      end
    end)
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup 'lsp-attach',
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end
    local vmap = function(keys, func, desc)
      vim.keymap.set('v', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end
    local function client_supports_method(client, method, bufnr)
      if vim.fn.has 'nvim-0.11' == 1 then
        return client:supports_method(method, bufnr)
      else
        return client.supports_method(method, { bufnr = bufnr })
      end
    end
    local function hover()
      local bufnr = event.buf
      local method = vim.lsp.protocol.Methods.textDocument_hover
      local clients = vim.lsp.get_clients { bufnr = bufnr }
      local supported = {}

      for _, client in ipairs(clients) do
        if client_supports_method(client, method, bufnr) then
          table.insert(supported, client)
        end
      end

      if #supported == 0 then
        vim.cmd('normal! K')
        return
      end

      local util = vim.lsp.util
      local params = util.make_position_params(0, supported[1].offset_encoding)
      local handler = vim.lsp.with(vim.lsp.handlers.hover, { focus_id = 'lsp-hover' })

      vim.lsp.buf_request_all(bufnr, method, params, function(results)
        local last_error

        for _, client in ipairs(supported) do
          local response = results[client.id]
          if response then
            if response.err then
              last_error = response.err
            elseif response.result and response.result.contents then
              handler(nil, response.result, {
                bufnr = bufnr,
                client_id = client.id,
                method = method,
              })
              return
            end
          end
        end

        if last_error then
          local message = type(last_error) == 'table' and (last_error.message or last_error.code) or last_error
          vim.notify(('Hover request failed: %s'):format(message), vim.log.levels.ERROR, { title = 'LSP Hover' })
          return
        end

        vim.notify('No information available', vim.log.levels.INFO, { title = 'LSP Hover' })
      end)
    end

    -- defaults:
    -- https://neovim.io/doc/user/news-0.11.html#_defaults

    map('gl', vim.diagnostic.open_float, 'Open Diagnostic Float')
    map('K', hover, 'Hover Documentation')
    map('gs', vim.lsp.buf.signature_help, 'Signature Documentation')
    map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
    -- map('gd', vim.lsp.buf.definition, 'Goto Definition')
    map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
    map('<leader>cr', vim.lsp.buf.rename, 'Rename all references')
    vmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
    vmap('<leader>cr', vim.lsp.buf.rename, 'Rename all references')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

      -- When cursor stops moving: Highlights all instances of the symbol under the cursor
      -- When cursor moves: Clears the highlighting
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      -- When LSP detaches: Clears the highlighting
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
        end,
      })
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'close_with_q',
  pattern = {
    'PlenaryTestPopup',
    'checkhealth',
    'dbout',
    'gitsigns-blame',
    'grug-far',
    'help',
    'lspinfo',
    'neotest-output',
    'neotest-output-panel',
    'neotest-summary',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set('n', 'q', function()
        vim.cmd 'close'
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = 'Quit buffer',
      })
    end)
  end,
})
