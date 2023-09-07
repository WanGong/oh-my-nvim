local M = {
  "phaazon/hop.nvim",
  event = "VeryLazy",
}

function M.config()
  require("hop").setup {}

  local hop = require "hop"
  local directions = require("hop.hint").HintDirection

  vim.keymap.set('', '<leader>hw', ":HopWord<CR>")
  vim.keymap.set('', '<leader>hl', ":HopLine<CR>")
  vim.keymap.set('', '<leader>hs', ":HopPattern<CR>")
end

return M
