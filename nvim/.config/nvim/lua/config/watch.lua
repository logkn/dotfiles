local uv = vim.uv or vim.loop

local M = {}

M.watches = {} ---@type table<string, uv.uv_fs_event_t>
M.enabled = false
M.changes = {} ---@type table<string, boolean>

local function debounce(fn, ms)
  local timer = assert(uv.new_timer())
  local argv = nil

  return function(...)
    argv = { ... }
    timer:stop()
    timer:start(ms, 0, function()
      timer:stop()
      vim.schedule(function()
        fn(unpack(argv))
      end)
    end)
  end
end

local function can_checktime()
  local mode = vim.api.nvim_get_mode().mode
  return mode:sub(1, 1) ~= 'c'
end

--- Refresh checktime and clear the changes log
function M.refresh()
  if not can_checktime() then
    return
  end

  pcall(vim.cmd.checktime)

  if vim.g.config_watch_debug then
    local keys = vim.tbl_keys(M.changes)
    table.sort(keys)
    vim.notify('# Changes\n- ' .. table.concat(keys, '\n- '), vim.log.levels.DEBUG)
  end

  M.changes = {}
end

--- Stop watching a specific path
---@param path string
function M.stop(path)
  local watch = M.watches[path]
  if watch then
    M.watches[path] = nil
    return watch:is_closing() or watch:close()
  end
end

--- Start watching a specific path
---@param path string
function M.start(path)
  if M.watches[path] ~= nil then
    return
  end

  if not (uv and uv.new_fs_event) then
    return
  end

  local watch = assert(uv.new_fs_event())

  local ok, err = watch:start(path, {}, function(werr, file)
    vim.schedule(function()
      if werr then
        M.changes[path] = true
      else
        local changed = file and file ~= '' and (path .. '/' .. file) or path
        M.changes[changed] = true
      end
      M.refresh()
    end)
  end)

  if not ok then
    if not watch:is_closing() then
      watch:close()
    end
    if vim.g.config_watch_debug then
      vim.notify('Failed to watch ' .. path .. ': ' .. tostring(err), vim.log.levels.WARN)
    end
    return
  end

  M.watches[path] = watch
end

---@param buf number
---@return string?
local function dirname(buf)
  local fname = vim.api.nvim_buf_get_name(buf)
  if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == '' and vim.bo[buf].buflisted and fname ~= '' and uv.fs_stat(fname) ~= nil then
    local path = vim.fs.dirname(fname)
    return path and path ~= '' and path or nil
  end
end

--- Update watches based on currently loaded buffers
--- Starts watches for new buffer directories and stops watches for removed ones
function M.update()
  local dirs = {} ---@type table<string, boolean>

  for _, buf in pairs(vim.api.nvim_list_bufs()) do
    local dir = dirname(buf)
    if dir then
      dirs[dir] = true
      M.start(dir)
    end
  end

  for path in pairs(M.watches) do
    if not dirs[path] then
      M.stop(path)
    end
  end
end

-- Give external tools a moment to finish writing (atomic renames can emit bursts of events).
M.refresh = debounce(M.refresh, 250)
M.update = debounce(M.update, 150)

--- Disable file system watching and stop all active watches
function M.disable()
  if not M.enabled then
    return
  end

  M.enabled = false
  pcall(vim.api.nvim_clear_autocmds, { group = 'config.watch' })
  pcall(vim.api.nvim_del_augroup_by_name, 'config.watch')

  for path in pairs(M.watches) do
    M.stop(path)
  end
end

--- Enable file system watching for all loaded buffers
function M.enable()
  if M.enabled then
    return
  end

  M.enabled = true

  vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete', 'BufWipeout', 'BufReadPost', 'BufWritePost' }, {
    group = vim.api.nvim_create_augroup('config.watch', { clear = true }),
    callback = M.update,
  })

  M.update()
end

return M
