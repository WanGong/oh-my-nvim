local M = {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
  },
}

function M.config()
  local icons = require "settings.icons"

  require("neogit").setup {
    auto_refresh = true,
    -- Change the default way of opening neogit
    kind = "tab",
    -- Change the default way of opening the commit message editor
    commit_editor = {
      kind = "split",
    },
    -- Change the default way of opening popups
    popup = {
      kind = "split",
    },
    -- customize displayed signs
    signs = {
      -- { CLOSED, OPENED }
      section = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
      item = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
      hunk = { "", "" },
    },
  }
end

return M
