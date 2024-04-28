local M = {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
}

function M.config()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  local harpoon = require "harpoon"
  -- REQUIRED
  harpoon:setup()
  -- REQUIRED

  keymap("n", "<leader>ha", function() harpoon:list():add() end)
  keymap("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
end

function M.mark_file()
  require("harpoon.mark").add_file()
  vim.notify "󱡅  marked file"
end

return M
