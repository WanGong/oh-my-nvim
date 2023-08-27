local M = {
  "inkarkat/vim-mark",
  event = "VeryLazy",
  dependencies = {
    {
      "inkarkat/vim-ingo-library",
      event = "VeryLazy",
    },
  },
}

function M.config()
  vim.g.mwDirectGroupJumpMappingNum = 20
  vim.g.mwDefaultHighlightingPalette = "maximum"
  vim.g.IngoLibrary_Marks = "0123456789abcdefghijklmnopqrstuvwxyz"
end

return M
