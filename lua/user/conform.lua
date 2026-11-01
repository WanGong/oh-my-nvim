local M = {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = { "ConformInfo", "FormatToggle" },
  dependencies = {
    -- formatters are installed by mason and only on PATH once it has loaded
    "mason-org/mason.nvim",
  },
  keys = {
    { "<leader>lf", function() require("conform").format { async = true } end, desc = "Format buffer" },
    { "ff", function() require("conform").format { async = true } end, desc = "Format buffer" },
  },
}

local prettier = { "prettier" }

function M.config()
  require("conform").setup {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "ruff_fix", "ruff_format" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      cuda = { "clang-format" },
      proto = { "clang-format" },
      java = { "google-java-format" },
      javascript = prettier,
      javascriptreact = prettier,
      typescript = prettier,
      typescriptreact = prettier,
      vue = prettier,
      css = prettier,
      scss = prettier,
      less = prettier,
      html = prettier,
      json = prettier,
      jsonc = prettier,
      yaml = prettier,
      graphql = prettier,
      markdown = { "prettier", "markdownlint" },
    },
    -- servers like gopls, rust_analyzer and bashls format the filetypes not listed above
    default_format_opts = { lsp_format = "fallback" },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 1000 }
    end,
    formatters = {
      prettier = { prepend_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } },
    },
  }

  vim.api.nvim_create_user_command("FormatToggle", function(args)
    if args.bang then
      vim.b.disable_autoformat = not vim.b.disable_autoformat
      vim.notify("Format on save (buffer): " .. (vim.b.disable_autoformat and "off" or "on"))
    else
      vim.g.disable_autoformat = not vim.g.disable_autoformat
      vim.notify("Format on save: " .. (vim.g.disable_autoformat and "off" or "on"))
    end
  end, { bang = true, desc = "Toggle format on save (! for current buffer only)" })
end

return M
