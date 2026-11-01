local M = {
  "folke/todo-comments.nvim",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TodoTelescope", "TodoTrouble", "TodoQuickFix" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
  keys = {
    { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Search TODOs" },
    { "<leader>sT", "<cmd>TodoTrouble<cr>", desc = "TODOs (Trouble)" },
  },
}

return M
