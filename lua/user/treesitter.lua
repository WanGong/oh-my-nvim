local M = {
  "nvim-treesitter/nvim-treesitter",
  -- the rewritten `main` branch needs Nvim 0.12; switch (and port this file) after upgrading
  branch = "master",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    {
      "nvim-tree/nvim-web-devicons",
      event = "VeryLazy",
    },
  },
}

function M.config()
  local configs = require "nvim-treesitter.configs"
  require("nvim-treesitter.install").prefer_git = true

  configs.setup {
    -- "all" pulls ~300 parsers on the frozen master branch, several of whose upstream repos no longer exist
    ensure_installed = {
      "bash", "c", "cpp", "css", "dockerfile", "go", "html", "javascript", "json", "lua", "luadoc",
      "markdown", "markdown_inline", "python", "query", "regex", "rust", "toml", "tsx", "typescript",
      "vim", "vimdoc", "yaml",
    },
    auto_install = true,
    ignore_install = { "" }, -- List of parsers to ignore installing
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

    highlight = {
      enable = true, -- false will disable the whole extension
      disable = { "css" }, -- list of language that will be disabled
    },
    indent = { enable = true, disable = { "python", "css" } },
  }
end

return M
