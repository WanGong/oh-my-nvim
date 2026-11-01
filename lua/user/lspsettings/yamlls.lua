return {
  settings = {
    yaml = {
      -- yamlls' built-in schema store fetching is replaced by schemastore.nvim's catalog
      schemaStore = { enable = false, url = "" },
      schemas = require("schemastore").yaml.schemas(),
    },
  },
}
