local M = {
  "nvim-treesitter/nvim-treesitter-textobjects",
  build = ":TSUpdate",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter",
      event = "VeryLazy",
    },
  },
}

function M.config() end

return M
