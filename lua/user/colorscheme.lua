local M = {
  "folke/tokyonight.nvim",
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}

-- not `M.name`: lazy.nvim reads `name` as the plugin's install directory name
M.colorscheme = "tokyonight-night"
function M.config()
  pcall(vim.cmd.colorscheme, M.colorscheme)
end

return M
