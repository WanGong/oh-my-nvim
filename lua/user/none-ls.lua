local M = {
  "nvimtools/none-ls.nvim",
  event = "BufReadPre",
  dependencies = {
    {
      "nvim-lua/plenary.nvim",
      "nvimtools/none-ls-extras.nvim",
      "gbprod/none-ls-shellcheck.nvim",
    },
  },
}

function M.config()
  local null_ls = require "null-ls"
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
  local formatting = null_ls.builtins.formatting
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
  local diagnostics = null_ls.builtins.diagnostics

  -- https://github.com/prettier-solidity/prettier-plugin-solidity
  null_ls.setup {
    debug = false,
    sources = {
      null_ls.builtins.completion.spell,

      -- format
      formatting.prettier.with {
        extra_filetypes = { "toml" },
        extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
      },
      -- formatting.black.with { extra_args = { "--fast" } },
      formatting.stylua,
      formatting.clang_format,
      formatting.google_java_format,
      formatting.isort,
      formatting.markdownlint,



      -- formatting.autoflake,
      -- formatting.autopep8,
      require "none-ls.formatting.jq",
      require "none-ls.formatting.ruff",
      -- require "none-ls.formatting.black".with { extra_args = { "--fast" } },
      -- formatting.shellcheck,

      -- diagnostics
      -- require "none-ls.diagnostics.beautysh",
      require "none-ls-shellcheck.diagnostics",
      require "none-ls.diagnostics.cpplint",
      -- require "none-ls.diagnostics.eslint", -- requires none-ls-extras.nvim
      require "none-ls.diagnostics.eslint_d",
      -- require "none-ls.diagnostics.ast_grep",
      require("none-ls.diagnostics.flake8").with { extra_args = { "--max-line-length", "100" } },

      -- diagnostics.beautysh,
      -- diagnostics.eslint_d,
      diagnostics.hadolint,
      diagnostics.golangci_lint,
      diagnostics.markdownlint,

      -- code action
      require "none-ls-shellcheck.code_actions",
      require "none-ls.code_actions.eslint_d",
    },
  }
end

return M
