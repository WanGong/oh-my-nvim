local M = {
  "DrKJeff16/project.nvim",
  event = "VeryLazy",
  dependencies = {
    {
      "nvim-telescope/telescope.nvim",
      event = "BufEnter",
      cmd = { "Telescope" },
    },
  },
}

function M.config()
  require("project").setup {
    -- NOTE: lsp detection will get annoying with multiple langs in one project
    lsp = { enabled = false },

    -- patterns used to detect root dir
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pom.xml" },
    manual_mode = false,
    exclude_dirs = {},
    show_hidden = false,
    silent_chdir = true,
    scope_chdir = "global",
  }

  local telescope = require "telescope"
  telescope.load_extension "projects"
end

return M
