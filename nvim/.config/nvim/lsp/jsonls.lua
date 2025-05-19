return {
  cmd = { "json-languageserver", "--stdio" },
  filetypes = { "json", "jsonc" },
  root_markers = { ".git" },
  single_file_support = true,
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
      format = { enable = true },
    },
  },
}

