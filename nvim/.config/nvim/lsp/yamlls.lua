return {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
  root_markers = { '.git' },
  single_file_support = true,
  settings = {
    yaml = {
      schemas = require('schemastore').yaml.schemas(),
      format = { enable = true },
      validate = true,
      hover = true,
      completion = true,
    },
  },
}