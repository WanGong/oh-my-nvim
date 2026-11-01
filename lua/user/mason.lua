-- Thus, Language Servers are external tools that must be installed separately from
-- Neovim. This is where `mason` and related plugins come into play.

-- Ensure the lsp servers and tools above are installed
--  To check the current status of installed tools and/or manually install
--  other tools, you can run
--    :Mason
--
--  You can press `g?` for help in this menu.

local M = {
  "mason-org/mason.nvim",
  cmd = "Mason",
  event = "BufReadPre",
  dependencies = {
    {
      "mason-org/mason-lspconfig.nvim",
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
    },
  },
}

local settings = {
  ui = {
    border = "none",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
  PATH = "prepend", -- "skip" seems to cause the spawning error
}

-- formatters and linters run by conform.nvim / nvim-lint (mason package names)
M.tools = {
  "clang-format",
  "cpplint",
  "golangci-lint",
  "google-java-format",
  "hadolint",
  "isort",
  "markdownlint",
  "prettier",
  "shellcheck", -- also used by bashls for diagnostics
  "stylua",
}

local function ensure_tools()
  local registry = require "mason-registry"
  registry.refresh(function()
    for _, name in ipairs(M.tools) do
      local ok, pkg = pcall(registry.get_package, name)
      if ok and not pkg:is_installed() and not pkg:is_installing() then
        vim.notify("mason: installing " .. name)
        pkg:install()
      end
    end
  end)
end

function M.config()
  require("mason").setup(settings)

  local lsp_ensure_installed = require "user.lspsettings.enabled_servers"
  require("mason-lspconfig").setup {
    ensure_installed = lsp_ensure_installed,
    automatic_enable = { exclude = { "stylua" } }, -- stylua runs as a formatter through conform
  }

  ensure_tools()

  require("mason-nvim-dap").setup {
    ensure_installed = { "python", "codelldb" },
    handlers = {
      function(config)
        require("mason-nvim-dap").default_setup(config)
      end,
      -- adapter and launch config live in user/dap.lua
      codelldb = function() end,
    },
  }
end

return M
