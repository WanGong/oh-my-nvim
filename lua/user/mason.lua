-- Thus, Language Servers are external tools that must be installed separately from
-- Neovim. This is where `mason` and related plugins come into play.

-- Ensure the lsp servers and tools above are installed
--  To check the current status of installed tools and/or manually install
--  other tools, you can run
--    :Mason
--
--  You can press `g?` for help in this menu.

local M = {
  "williamboman/mason.nvim",
  cmd = "Mason",
  event = "BufReadPre",
  dependencies = {
    {
      "williamboman/mason-lspconfig.nvim",
    },
    {
      "jay-babu/mason-null-ls.nvim",
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
    },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
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

function M.config()
  require("mason").setup(settings)

  local lsp_ensure_installed = require "user.lspsettings.enabled_servers"
  require("mason-lspconfig").setup {
    ensure_installed = lsp_ensure_installed,
    automatic_installation = true,
  }

  -- put all to none-ls, ref to: https://github.com/jay-babu/mason-null-ls.nvim?tab=readme-ov-file#primary-source-of-truth-is-null-ls
  require("mason-null-ls").setup {
    ensure_installed = nil,
    automatic_installation = true,
  }

  require("mason-tool-installer").setup {
    ensure_installed = lsp_ensure_installed,
    run_on_start = true,
  }

  vim.api.nvim_create_autocmd("User", {
    pattern = "MasonToolsStartingInstall",
    callback = function()
      vim.schedule(function()
        print "mason-tool-installer is starting"
      end)
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    pattern = "MasonToolsUpdateCompleted",
    callback = function(e)
      vim.schedule(function()
        print(vim.inspect(e.data)) -- print the table that lists the programs that were installed
      end)
    end,
  })
end

return M
