local M = {
  "rhysd/clever-f.vim",
  event = "VeryLazy",
}

function M.config()
  vim.g.clever_f_highlight_timeout_ms = 3000
  vim.keymap.set("n", ";", "<Plug>(clever-f-repeat-forward)")
  vim.keymap.set("n", ",", "<Plug>(clever-f-repeat-back)")
end

return M
