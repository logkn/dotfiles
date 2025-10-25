local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

local lsp_attach_group = vim.api.nvim_create_augroup('lsp-attach', { clear = false })

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
  group = lsp_attach_group,
  callback = function(event)
    local bufnr = event.buf

    local function map(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
    end
    local function vmap(keys, func, desc)
      vim.keymap.set('v', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
    end

    local function client_supports_method(client, method, b)
      if vim.fn.has 'nvim-0.11' == 1 then
        return client:supports_method(method, b)
      else
        return client.supports_method(method, { bufnr = b })
      end
    end

    -- your hover function unchanged (omitted for brevity) ...

    -- keymaps (unchanged)
    map('gl', vim.diagnostic.open_float, 'Open Diagnostic Float')
    map('K', vim.lsp.buf.hover, 'Hover Documentation')
    map('gs', vim.lsp.buf.signature_help, 'Signature Documentation')
    map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
    map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
    map('<leader>cr', vim.lsp.buf.rename, 'Rename all references')
    vmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
    vmap('<leader>cr', vim.lsp.buf.rename, 'Rename all references')

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, bufnr) then
      -- Make the highlight group unique per buffer
      local hl_group = vim.api.nvim_create_augroup(('lsp-highlight-%d'):format(bufnr), { clear = true })

      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        group = hl_group,
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        group = hl_group,
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
      })

      -- Scope LspDetach to this buffer and reuse the same buffer-unique group
      vim.api.nvim_create_autocmd('LspDetach', {
        group = hl_group, -- ties cleanup to this buffer’s group only
        buffer = bufnr, -- <- important: don’t affect other buffers
        callback = function()
          pcall(vim.lsp.buf.clear_references)
          vim.api.nvim_clear_autocmds { group = hl_group, buffer = bufnr }
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

vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave', 'BufEnter', 'CursorHold' }, {
  command = 'checktime',
})

-- Friendlier messages for external changes
vim.api.nvim_create_autocmd('FileChangedShellPost', {
  callback = function(args)
    vim.notify(('File changed on disk and reloaded: %s'):format(args.file), vim.log.levels.WARN, { title = 'autoread' })
  end,
})

-- Hide Copilot suggestions when Blink menu is open
-- vim.api.nvim_create_autocmd('User', {
--   pattern = 'BlinkCmpMenuOpen',
--   callback = function()
--     require('copilot.suggestion').dismiss()
--     vim.b.copilot_suggestion_hidden = true
--   end,
-- })
--
-- vim.api.nvim_create_autocmd('User', {
--   pattern = 'BlinkCmpMenuClose',
--   callback = function()
--     vim.b.copilot_suggestion_hidden = false
--   end,
-- })
