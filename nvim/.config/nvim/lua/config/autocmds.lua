local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

local lsp_attach_group = vim.api.nvim_create_augroup('lsp-attach', { clear = false })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = augroup 'kickstart-highlight-yank',
  callback = function()
    local on_yank = vim.hl and vim.hl.on_yank or vim.highlight.on_yank
    on_yank()
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

-- Check for file changes, good for ai coding agents that modify files
local watch = require 'config.watch'
watch.enable()

-- When a buffer is reloaded from disk via `checktime`, treesitter/LSP can lag behind.
-- Force a refresh so highlights/hover stay in sync with externally-edited files.
vim.api.nvim_create_autocmd('FileChangedShellPost', {
  group = augroup 'reload-refresh',
  callback = function(event)
    local buf = event.buf
    if not (buf and buf ~= 0 and vim.api.nvim_buf_is_valid(buf)) then
      return
    end

    -- Ensure treesitter highlighting is active for the reloaded buffer.
    -- Do this slightly deferred: `checktime` reloads can briefly leave the buffer mid-update.
    vim.defer_fn(function()
      if not (vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf)) then
        return
      end

      -- Prefer nvim-treesitter's buffer-scoped enable command when available.
      local ok_cmd = pcall(vim.api.nvim_buf_call, buf, function()
        vim.cmd 'silent! TSBufDisable highlight'
        vim.cmd 'silent! TSBufEnable highlight'
      end)
      if not ok_cmd then
        pcall(vim.treesitter.start, buf)
      end
    end, 50)

    -- Best-effort: some LSP servers can get out of sync on external reloads.
    -- Send a full-buffer didChange to attached clients.
    local clients = vim.lsp.get_clients { bufnr = buf }
    if #clients == 0 then
      return
    end

    local ok_lines, lines = pcall(vim.api.nvim_buf_get_lines, buf, 0, -1, false)
    if not ok_lines then
      return
    end

    local text = table.concat(lines, '\n')
    local uri = vim.uri_from_bufnr(buf)
    local version = vim.api.nvim_buf_get_changedtick(buf)

    for _, client in ipairs(clients) do
      if client.supports_method and client:supports_method('textDocument/didChange', buf) then
        client:notify('textDocument/didChange', {
          textDocument = { uri = uri, version = version },
          contentChanges = { { text = text } },
        })
      end
    end
  end,
})

-- Fallback: check on focus changes (some filesystems don't emit fs events)
vim.api.nvim_create_autocmd('FocusGained', {
  group = augroup 'checktime-on-focus',
  callback = watch.refresh,
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
