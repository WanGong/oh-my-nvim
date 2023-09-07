local M = {
  "liuchengxu/vista.vim",
  event = "VeryLazy",
}

function M.config()
  vim.keymap.set('', 'tb', ":Vista!!<CR>")
end

return M
