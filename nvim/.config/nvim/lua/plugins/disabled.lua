local disabled_plugins = {
  "nvim-neo-tree/neo-tree.nvim",
  "folke/trouble.nvim",
}

local function map_plugins(plugins)
  local mapped_plugins = {}
  for _, plugin in ipairs(plugins) do
    table.insert(mapped_plugins, { plugin, enabled = false })
  end
  return mapped_plugins
end

return map_plugins(disabled_plugins)
