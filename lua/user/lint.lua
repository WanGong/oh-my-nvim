local M = {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile", "BufWritePost" },
  dependencies = {
    -- linters are installed by mason and only on PATH once it has loaded
    "mason-org/mason.nvim",
  },
}

function M.config()
  local lint = require "lint"

  -- shellcheck, eslint and ruff diagnostics come from the bashls, eslint and ruff language servers
  lint.linters_by_ft = {
    c = { "cpplint" },
    cpp = { "cpplint" },
    dockerfile = { "hadolint" },
    go = { "golangcilint" },
    markdown = { "markdownlint" },
  }

  vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
    group = vim.api.nvim_create_augroup("user_lint", { clear = true }),
    callback = function()
      lint.try_lint()
    end,
  })
  -- the triggering BufReadPost already fired before this plugin loaded
  lint.try_lint()
end

return M
