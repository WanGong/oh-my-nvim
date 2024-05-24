local M = {
  "phaazon/hop.nvim",
  event = "VeryLazy",
}

function M.config()
  require("hop").setup {}

  local hop = require "hop"
  local directions = require("hop.hint").HintDirection

  vim.keymap.set("n", "<leader>hw", ":HopWord<CR>")
  vim.keymap.set("n", "<leader>hl", ":HopLine<CR>")
  vim.keymap.set("n", "<leader>hs", ":HopPattern<CR>")
  vim.keymap.set("v", "<leader>hw", "<cmd>HopWord<CR>")
  vim.keymap.set("v", "<leader>hl", "<cmd>HopLine<CR>")
  vim.keymap.set("v", "<leader>hs", "<cmd>HopPattern<CR>")
end

return M
