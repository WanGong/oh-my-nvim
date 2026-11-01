local M = {
  "liuchengxu/vista.vim",
  event = "VeryLazy",
}

function M.config()
  -- normal mode only: in operator-pending mode `dtb` (delete till "b") must keep working
  vim.keymap.set('n', 'tb', "<cmd>Vista!!<CR>", { desc = "Toggle Vista" })
end

return M
