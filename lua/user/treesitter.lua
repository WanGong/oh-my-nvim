local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = "VeryLazy",
    },
    {
      "nvim-tree/nvim-web-devicons",
      event = "VeryLazy",
    },
  },
}

function M.config()
  local configs = require "nvim-treesitter.configs"

  configs.setup {
    ensure_installed = "all", -- one of "all" or a list of languages
    auto_install = true,
    ignore_install = { "" }, -- List of parsers to ignore installing
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    prefer_git = true, -- install languages synchronously (only applied to `ensure_installed`)

    highlight = {
      enable = true, -- false will disable the whole extension
      disable = { "css" }, -- list of language that will be disabled
    },
    autopairs = {
      enable = true,
    },
    indent = { enable = true, disable = { "python", "css" } },
  }
end

return M
